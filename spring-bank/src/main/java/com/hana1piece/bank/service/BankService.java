package com.hana1piece.bank.service;

import com.hana1piece.bank.dto.AccountOpeningDTO;
import com.hana1piece.bank.dto.DepositDTO;
import com.hana1piece.bank.dto.TransferDTO;
import com.hana1piece.bank.dto.WithdrawDTO;
import com.hana1piece.bank.vo.AccountVO;
import com.hana1piece.bank.vo.BankTransactionVO;

import java.util.List;

public interface BankService {
    // 계좌 얻기
    AccountVO findAccountByAccountNumber(String accountNumber);

    // 계좌 거래내역 얻기
    List<BankTransactionVO> findBankTransactionByAccountNumber(String accountNumber);

    /* 프로시저 패키지 사용 */
    // 계좌 개설
    String accountOpening(AccountOpeningDTO accountOpeningDTO);

    // 입금
    void deposit(DepositDTO depositDTO);

    // 출금
    void withdraw(WithdrawDTO withdrawDTO);

    // 자행 이체
    void transfer(TransferDTO transferDTO);
}
