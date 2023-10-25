package com.hana1piece.wallet.model.vo;

import lombok.Data;

@Data
public class WalletTransactionVO {
    private int transactionNumber;
    private int walletNumber;
    private String classification;
    private String name;
    private long amount;
    private long balance;
    private String transactionDate;
}
