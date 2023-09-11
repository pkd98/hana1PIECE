package com.hana1piece.manager.model.dto;

import lombok.Data;

import javax.validation.constraints.NotEmpty;

@Data
public class ManagerLoginDTO {
    @NotEmpty
    private String id;
    @NotEmpty
    private String password;
}
