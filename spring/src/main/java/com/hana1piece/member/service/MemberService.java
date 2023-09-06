package com.hana1piece.member.service;

import com.hana1piece.member.model.dto.LoginDTO;
import com.hana1piece.member.model.dto.SignupDTO;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

import javax.servlet.http.HttpSession;

public interface MemberService {
    /**
     *  회원 가입
     */
    void signup(SignupDTO signupDTO);

    /**
     *  로그인
     */
    boolean login(LoginDTO loginDTO, HttpSession session);

    /**
     *  SMS 인증번호 요청
     */
    void getSmsCertificationNumber(String phoneNumber) throws CoolsmsException;

}
