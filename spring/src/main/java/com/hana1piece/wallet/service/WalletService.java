package com.hana1piece.wallet.service;

import com.hana1piece.member.model.vo.OneMembersVO;
import com.hana1piece.wallet.model.dto.DepositDTO;
import com.hana1piece.wallet.model.dto.TransferDTO;
import com.hana1piece.wallet.model.dto.WithdrawDTO;
import com.hana1piece.wallet.model.vo.WalletTransactionVO;
import com.hana1piece.wallet.model.vo.WalletVO;

public interface WalletService {

    WalletVO findWalletByWN(int walletNumber);

    WalletVO findWalletByMemberId(String memberId);

    void walletDeposit(OneMembersVO member, DepositDTO depositDTO) throws Exception;

    void walletWithdraw(OneMembersVO member, WithdrawDTO withdrawDTO) throws Exception;

    void recordTransaction(WalletTransactionVO walletTransactionVO);

    boolean requestBankAccountTransfer(TransferDTO transferDTO);

}
