package com.hana1piece.wallet.model.dto;

import lombok.Data;

@Data
public class UpdateWalletBalanceDTO {
    private long amount;
    private int walletNumber;
}
