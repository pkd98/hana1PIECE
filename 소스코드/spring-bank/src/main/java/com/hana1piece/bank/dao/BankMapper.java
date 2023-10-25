package com.hana1piece.bank.dao;

import com.hana1piece.bank.dto.AccountOpeningDTO;
import com.hana1piece.bank.dto.DepositDTO;
import com.hana1piece.bank.dto.TransferDTO;
import com.hana1piece.bank.dto.WithdrawDTO;
import com.hana1piece.bank.vo.AccountVO;
import com.hana1piece.bank.vo.BankTransactionVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BankMapper {

    // 계좌 번호 순번 가져오기
    int getAccountSerialNumber();

    // 계좌 얻기
    AccountVO findAccountByAccountNumber(String accountNumber);

    // 계좌 거래내역 얻기
    List<BankTransactionVO> findBankTransactionByAccountNumber(String accountNumber);

    /* 프로시저 패키지 사용 */
    // 계좌 개설
    void callAccountOpening(AccountOpeningDTO accountOpeningDTO);

    // 계좌 거래내역 초기화
    void insertBankTransaction(BankTransactionVO bankTransactionVO);

    // 입금
    void callDeposit(DepositDTO depositDTO);

    // 출금
    void callWithdraw(WithdrawDTO withdrawDTO);

    // 자행 이체
    void callTransfer(TransferDTO transferDTO);

    int deleteAccount(String accountNumber);
}
