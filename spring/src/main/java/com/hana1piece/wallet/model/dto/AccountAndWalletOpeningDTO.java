package com.hana1piece.wallet.model.dto;

import lombok.Data;

import javax.validation.constraints.NotEmpty;

@Data
public class AccountAndWalletOpeningDTO {
    @NotEmpty
    private String registrationNumber1;
    @NotEmpty
    private String registrationNumber2;
    @NotEmpty
    private String accountPassword;
    @NotEmpty
    private String walletPassword;
    private String referralCode;
}
