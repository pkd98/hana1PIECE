package com.hana1piece.manager.model.vo;

import lombok.Data;

import javax.validation.constraints.NotEmpty;

@Data
public class ManagerVO {
    private String id;
    private String password;
    private String name;
    private String enrollDate;
    private String image;
    private String position;
    private String introduction;
}
