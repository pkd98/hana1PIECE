package com.hana1piece.member.model.vo;

import lombok.Data;

@Data
public class WallletVO {
    private int wallet_number;
    private String memberId;
    private String accountNumber;
    private String password;
    private int balance;
    private String openingDate;
}
