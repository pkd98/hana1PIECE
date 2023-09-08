package com.hana1piece.member.model.vo;

import lombok.Data;

@Data
public class AccountVO {
    private String accountNumber;
    private String password;
    private long balance;
    private String openingDate;
    private String residentNumber1;
    private String residentNumber2;
    private String name;
}
