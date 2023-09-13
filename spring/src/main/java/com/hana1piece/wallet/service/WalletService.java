package com.hana1piece.wallet.service;

import com.hana1piece.member.model.vo.OneMembersVO;
import com.hana1piece.wallet.model.dto.DepositDTO;
import com.hana1piece.wallet.model.dto.TransferDTO;
import com.hana1piece.wallet.model.dto.WithdrawDTO;
import com.hana1piece.wallet.model.vo.AccountVO;
import com.hana1piece.wallet.model.vo.BankTransactionVO;
import com.hana1piece.wallet.model.vo.WalletTransactionVO;
import com.hana1piece.wallet.model.vo.WalletVO;

import java.util.List;

public interface WalletService {

    WalletVO findWalletByWN(int walletNumber);

    WalletVO findWalletByMemberId(String memberId);

    List<WalletTransactionVO> findWalletTransactionByWalletNumber(int walletNumber);

    void walletDeposit(OneMembersVO member, DepositDTO depositDTO) throws Exception;

    void walletWithdraw(OneMembersVO member, WithdrawDTO withdrawDTO) throws Exception;

    void updateWalletBalance(WalletVO walletVO, WalletTransactionVO walletTransactionVO);

    void recordTransaction(WalletTransactionVO walletTransactionVO);

    boolean requestBankAccountTransfer(TransferDTO transferDTO);

    AccountVO requestBankAccount(String accountNumber);

    List<BankTransactionVO> requestBankAccountTransaction(String accountNumber);
}
