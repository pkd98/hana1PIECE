package com.hana1piece.member.model.dto;

import lombok.Data;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.Email;
import javax.validation.constraints.Size;

@Data
public class SignupDTO {
    @NotEmpty
    @Size(min = 6)
    private String id;
    @NotEmpty
    private String name;
    @NotEmpty
    @Size(min = 6)
    private String password;
    @NotEmpty
    @Size(min = 6)
    private String passwordCheck;
    @NotEmpty
    @Size(min = 11, max = 11)
    private String phone;
    @NotEmpty
    @Email
    private String email;
}
