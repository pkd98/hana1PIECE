package com.hana1piece.wallet.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hana1piece.logger.service.LoggerService;
import com.hana1piece.member.model.vo.OneMembersVO;
import com.hana1piece.wallet.model.dto.DepositDTO;
import com.hana1piece.wallet.model.dto.TransferDTO;
import com.hana1piece.wallet.model.dto.UpdateWalletBalanceDTO;
import com.hana1piece.wallet.model.dto.WithdrawDTO;
import com.hana1piece.wallet.model.mapper.WalletMapper;
import com.hana1piece.wallet.model.vo.AccountVO;
import com.hana1piece.wallet.model.vo.BankTransactionVO;
import com.hana1piece.wallet.model.vo.WalletTransactionVO;
import com.hana1piece.wallet.model.vo.WalletVO;
import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;
import java.util.List;

@Service
@Transactional
public class WalletServiceImpl implements WalletService {
    @Value("${hanabank.server.url}")
    private String bankServerUrl;
    @Value("${manager.account.password}")
    private String managerAccountPassword;
    private final LoggerService loggerService;
    private final WalletMapper walletMapper;
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;

    @Autowired
    WalletServiceImpl(LoggerService loggerService, WalletMapper walletMapper, RestTemplate restTemplate, ObjectMapper objectMapper) {
        this.loggerService = loggerService;
        this.walletMapper = walletMapper;
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
    }

    @Override
    public WalletVO findWalletByWN(int walletNumber) {
        return walletMapper.findWalletByWN(walletNumber);
    }

    @Override
    public WalletVO findWalletByMemberId(String memberId) {
        return walletMapper.findWalletByMemberId(memberId);
    }

    @Override
    public List<WalletTransactionVO> findWalletTransactionByWalletNumber(int walletNumber) {
        return walletMapper.findWalletTransactionByWN(walletNumber);
    }

    /**
     * [지갑 현금 입금 : 연동 하나은행 계좌 출금]
     * 1. 하나은행 - 사용자 계좌 -> 관리자 계좌 이체
     * 2. 사용자 지갑에 현금 입금
     * 3. 지갑 거래내역 기록
     *
     * @param deposit
     */
    @Override
    public void walletDeposit(OneMembersVO member, DepositDTO deposit) throws Exception {
        try {
            WalletVO oldWallet = findWalletByMemberId(member.getId());

            /**
             *  계좌 비밀번호 유효성 검사
             */
            if (!requestBankAccount(oldWallet.getAccountNumber()).getPassword().equals(deposit.getAccountPassword())) {
                throw new Exception();
            }

            /**
             *  1. 하나은행 사용자 계좌에서 관리자 계좌로 이체 요청
             */
            TransferDTO transferDTO = new TransferDTO();
            transferDTO.setAccountNumber(oldWallet.getAccountNumber());
            transferDTO.setPassword(deposit.getAccountPassword());
            transferDTO.setAmount(deposit.getAmount());
            transferDTO.setName("(주)하나1PIECE 지갑 입금");
            transferDTO.setRecipientAccountNumber("99900000000394"); // 관리자 계좌
            boolean isSuccess = requestBankAccountTransfer(transferDTO);
            if (!isSuccess) {
                throw new Exception();
            }
            /**
             *  2. 사용자 지갑에 현금 입금
             */
            deposit.setWalletNumber(oldWallet.getWalletNumber());
            walletMapper.deposit(deposit);

            /**
             *  3. 지갑 거래내역 기록
             */
            WalletTransactionVO walletTransactionVO = new WalletTransactionVO();
            walletTransactionVO.setWalletNumber(oldWallet.getWalletNumber());
            walletTransactionVO.setClassification("IN");
            walletTransactionVO.setName("현금 입금");
            walletTransactionVO.setAmount(deposit.getAmount());
            walletTransactionVO.setBalance(oldWallet.getBalance() + deposit.getAmount());
            recordTransaction(walletTransactionVO);
        } catch (Exception e) {
            loggerService.logException("ERR", "walletDeposit", e.getMessage(), "");
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * [지갑 현금 출금 : 연동 하나은행 계좌 입금]
     * 1. 사용자 지갑에 현금 출금
     * 2. 지갑 거래내역 기록
     * 3. 하나은행 관리자 계좌 -> 사용자 계좌 이체
     *
     * @param withdraw
     */
    @Override
    public void walletWithdraw(OneMembersVO member, WithdrawDTO withdraw) throws Exception {
        try {
            WalletVO oldWallet = findWalletByMemberId(member.getId());
            WalletTransactionVO walletTransactionVO = new WalletTransactionVO();
            walletTransactionVO.setWalletNumber(oldWallet.getWalletNumber());
            walletTransactionVO.setClassification("OUT");
            walletTransactionVO.setName("현금 출금");
            walletTransactionVO.setAmount(-1 * withdraw.getAmount());
            walletTransactionVO.setBalance(oldWallet.getBalance() - withdraw.getAmount());

            /**
             *  지갑 비밀번호 유효성 검사
             */
            if (!withdraw.getWalletPassword().equals(oldWallet.getPassword())) {
                throw new Exception();
            }

            /**
             *   1. 사용자 지갑에 현금 출금
             */
            withdraw.setWalletNumber(oldWallet.getWalletNumber());
            walletMapper.withdraw(withdraw);

            /**
             *   2. 지갑 거래내역 기록
             */
            recordTransaction(walletTransactionVO);

            /**
             *   3. 하나은행 관리자 계좌 -> 사용자 계좌 이체
             */
            System.out.println(oldWallet.toString());
            TransferDTO transferDTO = new TransferDTO();
            transferDTO.setAccountNumber("99900000000394");
            transferDTO.setPassword(managerAccountPassword);
            transferDTO.setAmount(withdraw.getAmount());
            transferDTO.setName("(주)하나1PIECE 지갑 출금");
            transferDTO.setRecipientAccountNumber(oldWallet.getAccountNumber());
            boolean isSuccess = requestBankAccountTransfer(transferDTO);
            if (!isSuccess) {
                throw new Exception();
            }

        } catch (Exception e) {
            loggerService.logException("ERR", "walletWithdraw", e.getMessage(), "");
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * 지갑 잔액 업데이트
     */
    @Override
    public void updateWalletBalance(WalletVO walletVO, WalletTransactionVO walletTransactionVO) {
        try {
            UpdateWalletBalanceDTO updateWalletBalanceDTO = new UpdateWalletBalanceDTO();
            updateWalletBalanceDTO.setWalletNumber(walletVO.getWalletNumber());
            updateWalletBalanceDTO.setAmount(walletTransactionVO.getAmount());
            recordTransaction(walletTransactionVO);
            walletMapper.updateWalletBalance(updateWalletBalanceDTO);
        } catch (Exception e) {
            loggerService.logException("ERR", "recordTransaction", e.getMessage(), "");
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * 지갑 거래 내역 기록
     *
     * @param walletTransactionVO
     */
    @Override
    public void recordTransaction(WalletTransactionVO walletTransactionVO) {
        try {
            walletMapper.insertWalletTransaction(walletTransactionVO);
        } catch (Exception e) {
            loggerService.logException("ERR", "recordTransaction", e.getMessage(), "");
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * 하나은행 PUT 요청 [RestTemplate 이용]
     *
     * @param transferDTO
     * @return
     */
    @Override
    public boolean requestBankAccountTransfer(TransferDTO transferDTO) {
        String url = bankServerUrl + "transfer";

        // HTTP 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // HTTP 요청 엔티티 생성
        HttpEntity<TransferDTO> requestEntity = new HttpEntity<>(transferDTO, headers);

        // HTTP PUT 요청 보내기
        ResponseEntity<String> responseEntity = restTemplate.exchange(
                url,
                HttpMethod.PUT,
                requestEntity,
                String.class
        );

        // 응답 확인
        if (responseEntity.getStatusCode() == HttpStatus.OK) {
            String response = responseEntity.getBody();
            System.out.println("응답 본문: " + response);
            return true;
        } else {
            System.out.println("요청 실패: " + responseEntity.getStatusCode());
            return false;
        }
    }

    /**
     * 하나은행 계좌 정보 Get 요청 [RestTemplate 이용]
     *
     * @param accountNumber
     * @return
     */
    @Override
    public AccountVO requestBankAccount(String accountNumber) {
        String url = bankServerUrl + "account/" + accountNumber;

        // GET 요청을 보내고 응답을 JSON 형식의 String으로 받음
        ResponseEntity<String> responseEntity = restTemplate.getForEntity(url, String.class);

        // 응답 확인
        if (responseEntity.getStatusCode().is2xxSuccessful()) {
            String responseBody = responseEntity.getBody();
            System.out.println(responseBody);
            // JSON 문자열을 AccountVO 객체로 매핑
            try {
                // JSON 응답의 "data" 필드의 값만 추출
                JsonNode root = objectMapper.readTree(responseBody);
                JsonNode dataNode = root.path("data");

                // "data" 필드의 JSON 값을 AccountVO 객체로 변환
                AccountVO accountVO = objectMapper.treeToValue(dataNode, AccountVO.class);
                System.out.println(accountVO.toString());
                return accountVO;
            } catch (Exception e) {
                loggerService.logException("ERR", "requestBankAccount", e.getMessage(), "");
                e.printStackTrace();
            }
        } else {
            System.out.println("요청 실패: " + responseEntity.getStatusCode());
        }
        return null;
    }

    /**
     * 하나은행 계좌 거래내역 Get 요청 [RestTemplate 이용]
     *
     * @param accountNumber
     * @return
     */
    @Override
    public List<BankTransactionVO> requestBankAccountTransaction(String accountNumber) {
        String url = bankServerUrl + "bankTransaction/" + accountNumber;

        // GET 요청을 보내고 응답을 String으로 받음
        ResponseEntity<String> responseEntity = restTemplate.getForEntity(url, String.class);

        // 응답 확인
        if (responseEntity.getStatusCode().is2xxSuccessful()) {
            String responseBody = responseEntity.getBody();

            // JSON 문자열을 ObjectMapper를 사용하여 JsonNode로 읽음
            try {
                JsonNode root = objectMapper.readTree(responseBody);
                JsonNode dataNode = root.get("data");

                // JsonNode를 List<BankTransactionVO>로 매핑
                List<BankTransactionVO> transactionList = objectMapper.readValue(
                        dataNode.toString(),
                        new TypeReference<List<BankTransactionVO>>() {
                        }
                );
                return transactionList;
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("요청 실패: " + responseEntity.getStatusCode());
        }

        return Collections.emptyList();
    }

}
