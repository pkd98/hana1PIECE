package com.hana1piece.member.service;

import com.hana1piece.member.model.dto.*;
import com.hana1piece.member.model.vo.OneMembersVO;
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
    void getSmsCertificationNumber(String phoneNumber, HttpSession session) throws CoolsmsException;

    /**
     *  SMS 인증번호 검증
     */
    boolean isVerifySms(String userInput, HttpSession session);

    /**
     *  계좌, 지갑 개설 및 연동
     */
    void accountAndWalletOpening(OneMembersVO member, AccountAndWalletOpeningDTO accountAndWalletOpeningDTO);

    /**
     *  하나은행에 계좌 개설 Get 요청 보내기
     */
    String accountOpening(AccountOpeningDTO accountOpeningDTO);

    /**
     *  지갑 개설 및 계좌 연동
     */
    void walletOpening(WalletOpeningDTO walletOpeningDTO);

    /**
     * 추천인 이벤트: 추천인 추천자 5000원 지급
     */
    boolean event(String memberId, String referralCode);


}
