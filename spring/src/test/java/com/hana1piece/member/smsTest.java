package com.hana1piece.member;

import com.hana1piece.member.service.MemberService;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.servlet.http.HttpSession;

import static org.junit.jupiter.api.Assertions.fail;
import static org.mockito.Mockito.mock;

@SpringBootTest
public class smsTest {

    @Autowired
    private MemberService memberService;
    private HttpSession session;

    @BeforeEach
    public void setUp() {
        // HttpSession의 Mock 객체 생성
        session = mock(HttpSession.class);
    }

    @Test
    @DisplayName("SMS 테스트")
    public void smsTest() {
        try {
            memberService.getSmsCertificationNumber("01012341234", session);
        } catch(Exception e) {
            fail("SMS 에러 발생" + e.getMessage());
        }
    }

}