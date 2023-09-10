package com.hana1piece.wallet.service;

import com.hana1piece.logger.service.LoggerService;
import com.hana1piece.member.model.vo.OneMembersVO;
import com.hana1piece.wallet.model.dto.DepositDTO;
import com.hana1piece.wallet.model.dto.TransferDTO;
import com.hana1piece.wallet.model.dto.WithdrawDTO;
import com.hana1piece.wallet.model.mapper.WalletMapper;
import com.hana1piece.wallet.model.vo.WalletTransactionVO;
import com.hana1piece.wallet.model.vo.WalletVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

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

    @Autowired
    WalletServiceImpl(LoggerService loggerService, WalletMapper walletMapper, RestTemplate restTemplate) {
        this.loggerService = loggerService;
        this.walletMapper = walletMapper;
        this.restTemplate = restTemplate;
    }

    @Override
    public WalletVO findWalletByWN(int walletNumber) {
        return walletMapper.findWalletByWN(walletNumber);
    }

    @Override
    public WalletVO findWalletByMemberId(String memberId) {
        return walletMapper.findWalletByMemberId(memberId);
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
             *  1. 하나은행 사용자 계좌에서 관리자 계좌로 이체 요청
             */
            TransferDTO transferDTO = new TransferDTO();
            transferDTO.setAccountNumber(oldWallet.getAccountNumber());
            transferDTO.setPassword(deposit.getAccountPassword());
            transferDTO.setAmount(deposit.getAmount());
            transferDTO.setName("(주)하나1PIECE 지갑 입금");
            transferDTO.setRecipientAccountNumber("99900000000394"); // 관리자 계좌
            boolean isSuccess = requestBankAccountTransfer(transferDTO);
            if(!isSuccess) {
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
            TransferDTO transferDTO = new TransferDTO();
            transferDTO.setAccountNumber("99900000000394");
            transferDTO.setPassword(managerAccountPassword);
            transferDTO.setAmount(withdraw.getAmount());
            transferDTO.setName("(주)하나1PIECE 지갑 출금");
            transferDTO.setRecipientAccountNumber(oldWallet.getAccountNumber());
            boolean isSuccess = requestBankAccountTransfer(transferDTO);
            if(!isSuccess) {
                throw new Exception();
            }

        } catch (Exception e) {
            loggerService.logException("ERR", "walletWithdraw", e.getMessage(), "");
            e.printStackTrace();
            throw e;
        }
    }

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

    @Override
    public boolean requestBankAccountTransfer(TransferDTO transferDTO) {
        // HTTP 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // HTTP 요청 엔티티 생성
        HttpEntity<TransferDTO> requestEntity = new HttpEntity<>(transferDTO, headers);

        // HTTP PUT 요청 보내기
        ResponseEntity<String> responseEntity = restTemplate.exchange(
                bankServerUrl,
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
}
