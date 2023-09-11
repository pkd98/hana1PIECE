package com.hana1piece.wallet.model.dto;

import lombok.Data;

import javax.validation.constraints.Min;
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
    @Min(1)
    private long amount;
}
