package com.hana1piece.wallet.model.vo;

import lombok.Data;

@Data
public class WalletVO {
    private int walletNumber;
    private String memberId;
    private String accountNumber;
    private String password;
    private long balance;
    private String openingDate;
}
