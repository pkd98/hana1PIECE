package com.hana1piece.wallet.model.dto;

import lombok.Data;

@Data
public class TransferDTO {
    private String accountNumber;
    private String password;
    private long amount;
    private String name;
    private String RecipientAccountNumber;
}
