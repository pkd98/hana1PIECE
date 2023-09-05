package com.hana1piece.member.model.vo;

import lombok.Data;

@Data
public class OneMembersVO {
    private String id;
    private String name;
    private String password;
    private String phone;
    private String email;
    private String referralCode;
    private int referralCount;
}
