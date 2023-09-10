package com.hana1piece.wallet;

import com.hana1piece.wallet.model.dto.UpdateWalletBalanceDTO;
import com.hana1piece.wallet.model.mapper.WalletMapper;
import com.hana1piece.wallet.service.WalletService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class WalletTest {
    @Autowired
    private WalletService walletService;
    @Autowired
    WalletMapper walletMapper;

    @Test
    @DisplayName("지갑 입금 테스트")
    public void DepositTest() {
    }

    @Test
    @DisplayName("지갑 출금 테스트")
    public void WithdrawTest() {
    }



}
