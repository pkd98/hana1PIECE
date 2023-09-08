package com.hana1piece.member.model.dto;

import lombok.Data;

@Data
public class WalletOpeningDTO {
    private String memberId;
    private String accountNumber;
    private String password;
}
