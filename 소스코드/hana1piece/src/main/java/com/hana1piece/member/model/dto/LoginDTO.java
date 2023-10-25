package com.hana1piece.member.model.dto;

import lombok.Data;
import org.hibernate.validator.constraints.NotEmpty;

@Data
public class LoginDTO {
    @NotEmpty
    private String id;
    @NotEmpty
    private String password;
}
