package com.hana1piece.wallet.model.mapper;

import com.hana1piece.wallet.model.dto.DepositDTO;
import com.hana1piece.wallet.model.dto.UpdateWalletBalanceDTO;
import com.hana1piece.wallet.model.dto.WithdrawDTO;
import com.hana1piece.wallet.model.vo.WalletTransactionVO;
import com.hana1piece.wallet.model.vo.WalletVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface WalletMapper {

    List<WalletVO> findAllWallet();

    WalletVO findWalletByWN(int walletNumber);

    WalletVO findWalletByMemberId(String memberId);

    List<WalletTransactionVO> findAllWalletTransaction();

    List<WalletTransactionVO> findWalletTransactionByWN(int walletNumber);

    void updateWalletBalance(UpdateWalletBalanceDTO updateWalletBalanceDTO);

    void deposit(DepositDTO depositDTO);

    void withdraw(WithdrawDTO withdrawDTO);

    void insertWalletTransaction(WalletTransactionVO walletTransactionVO);

}
