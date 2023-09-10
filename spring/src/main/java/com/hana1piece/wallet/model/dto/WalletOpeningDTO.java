package com.hana1piece.wallet.model.dto;

import lombok.Data;

@Data
public class WalletOpeningDTO {
    private String memberId;
    private String accountNumber;
    private String password;
}
