package com.hana1piece.wallet.model.dto;

import lombok.Data;

import javax.validation.constraints.NotEmpty;

@Data
public class WithdrawDTO {
    /*
    private String accountNumber;
    private long accountBalance;
     */
    private int walletNumber;
    @NotEmpty
    private String walletPassword;
    @NotEmpty
    private long amount;
}
