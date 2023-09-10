package com.hana1piece.wallet.model.dto;

import lombok.Data;

@Data
public class AccountOpeningDTO {
    private String accountNumber;
    private String password;
    private String residentNumber1;
    private String residentNumber2;
    private String name;
}
