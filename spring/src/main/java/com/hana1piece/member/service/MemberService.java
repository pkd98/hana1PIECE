package com.hana1piece.member.service;

import com.hana1piece.member.model.dto.SignupDTO;

public interface MemberService {

    /**
     *  회원 가입
     */
    void signup(SignupDTO signupDTO);

    /**
     *  로그인
     */

}
