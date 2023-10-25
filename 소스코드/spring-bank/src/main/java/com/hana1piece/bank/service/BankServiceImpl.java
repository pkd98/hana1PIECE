package com.hana1piece.bank.service;

import com.hana1piece.bank.dao.BankMapper;
import com.hana1piece.bank.dto.AccountOpeningDTO;
import com.hana1piece.bank.dto.DepositDTO;
import com.hana1piece.bank.dto.TransferDTO;
import com.hana1piece.bank.dto.WithdrawDTO;
import com.hana1piece.bank.vo.AccountVO;
import com.hana1piece.bank.vo.BankTransactionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BankServiceImpl implements BankService {

    private final BankMapper bankMapper;

    @Autowired
    public BankServiceImpl(BankMapper bankMapper) {
        this.bankMapper = bankMapper;
    }

    @Override
    public AccountVO findAccountByAccountNumber(String accountNumber) {
        return bankMapper.findAccountByAccountNumber(accountNumber);
    }

    @Override
    public List<BankTransactionVO> findBankTransactionByAccountNumber(String accountNumber) {
        return bankMapper.findBankTransactionByAccountNumber(accountNumber);
    }

    @Override
    public String accountOpening(AccountOpeningDTO accountOpeningDTO) {
        /**
         *  [계좌 번호 생성] : 999-ZZZZZZ-ZZ394
         *  앞 999, 뒤 194 고정 및 Z 부분 Sequence 이용 생성
         */
        StringBuilder sb = new StringBuilder();
        String accountSerialNumber = String.format("%08d", bankMapper.getAccountSerialNumber());

        sb.append("999");
        sb.append(accountSerialNumber);
        sb.append("394");

        /**
         *  생성된 계좌번호 지정 후 계좌 개설 프로시저 호출
         */
        accountOpeningDTO.setAccountNumber(sb.toString());
        bankMapper.callAccountOpening(accountOpeningDTO);

        if(findAccountByAccountNumber(sb.toString()) != null){
            // 생성한 계좌번호 리턴
            initBankTransaction(sb.toString());
            return sb.toString();
        } else {
            return null;
        }
    }

    @Override
    public void initBankTransaction(String accountNumber) {
        BankTransactionVO bankTransactionVO = new BankTransactionVO();
        bankTransactionVO.setName("개설");
        bankTransactionVO.setBalance(0);
        bankTransactionVO.setAccountNumber(accountNumber);
        bankTransactionVO.setAmount(0);
        bankTransactionVO.setClassification("N");
        bankTransactionVO.setRecipientAccountNumber("-");
        bankMapper.insertBankTransaction(bankTransactionVO);
    }

    @Override
    public void deposit(DepositDTO depositDTO) {
        bankMapper.callDeposit(depositDTO);
    }

    @Override
    public void withdraw(WithdrawDTO withdrawDTO) {
        bankMapper.callWithdraw(withdrawDTO);
    }

    @Override
    public void transfer(TransferDTO transferDTO) {
        bankMapper.callTransfer(transferDTO);
    }
}
