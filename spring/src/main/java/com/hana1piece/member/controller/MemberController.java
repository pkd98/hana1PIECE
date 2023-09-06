package com.hana1piece.member.controller;

import com.hana1piece.member.model.dto.LoginDTO;
import com.hana1piece.member.model.dto.SignupDTO;
import com.hana1piece.member.service.MemberService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.validation.Errors;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.Random;

@Controller
public class MemberController {
    private final MemberService memberService;

    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @GetMapping("/")
    public String index() {
        return "index";
    }

    /**
     * 회원 가입
     */
    @PostMapping("/signup")
    public ResponseEntity signup(@Valid @RequestBody SignupDTO signupDTO, BindingResult bindingResult) {
        // 유효성 검사 실패
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body("Validation failed: " + bindingResult.getAllErrors());
        }
        try {
            // 정상 회원가입 성공
            memberService.signup(signupDTO);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            //회원가입 실패
            return ResponseEntity.badRequest().build();
        }
    }

    /**
     * 로그인
     */
    @PostMapping("/login")
    public ResponseEntity login(@Valid @RequestBody LoginDTO loginDTO, BindingResult bindingResult, HttpSession session) {
        try {
            // 잘못된 접근
            if (bindingResult.hasErrors()) {
                return ResponseEntity.badRequest().body("Validation failed: " + bindingResult.getAllErrors());
            }
            // 아이디 비밀번호 불일치
            boolean state = memberService.login(loginDTO, session);
            if (!state) {
                return ResponseEntity.badRequest().body("Validation failed: " + bindingResult.getAllErrors());
            } else {
                System.out.println(session.getAttribute("member").toString());
                // 로그인 성공
                return ResponseEntity.ok().build();
            }
        } catch (Exception e) {
            // 예기치 못한 에러
            return ResponseEntity.badRequest().build();
        }
    }

    /**
     * 로그아웃
     */
    @GetMapping("/logout")
    public String signout(HttpSession session) {
        session.removeAttribute("member");
        return "redirect:/";
    }

    /**
     *  계좌 개설
     */
    @GetMapping("/account-opening")
    public String accountOpening() {
        return "account-opening";
    }

    /**
     *  종합 계좌 개설 프로세스 1
     */
    @GetMapping("/accountOpeningProcess1")
    public String accountOpeningProcess1() {
        return "account-opening-process1";
    }

    /**
     *  종합 계좌 개설 프로세스 2
     */
    @GetMapping("/accountOpeningProcess2")
    public String accountOpeningProcess2() {
        return "account-opening-process2";
    }

    /**
     *  CoolSMS 이용 SMS 인증번호 요청
     */
    @GetMapping("/sms")
    public ResponseEntity sendSMS(@RequestParam("phone") String phone) {
        try {
            // sms 전송
            System.out.println("test");
            memberService.getSmsCertificationNumber(phone);
            System.out.println("Test");
            // 정상 전송됨
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }



}
