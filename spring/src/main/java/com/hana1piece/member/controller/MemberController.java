package com.hana1piece.member.controller;

import com.hana1piece.member.model.dto.AccountAndWalletOpeningDTO;
import com.hana1piece.member.model.dto.AccountOpeningDTO;
import com.hana1piece.member.model.dto.LoginDTO;
import com.hana1piece.member.model.dto.SignupDTO;
import com.hana1piece.member.model.vo.OneMembersVO;
import com.hana1piece.member.service.MemberService;
import org.apache.ibatis.annotations.One;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
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
     * 계좌 개설 페이지
     */
    @GetMapping("/account-opening")
    public String accountOpening() {
        return "account-opening";
    }

    /**
     *  계좌 개설 및 지갑 연동 서비스 처리
     */
    @PostMapping("/account-opening")
    public ResponseEntity accountOpeningProcess(@Valid AccountAndWalletOpeningDTO accountAndWalletOpeningDTO, BindingResult br, HttpSession session) {
        System.out.println(accountAndWalletOpeningDTO.toString());
        try {
            OneMembersVO member = (OneMembersVO) session.getAttribute("member");
            // 세션 만료 리턴
            if (member == null) {
                return null;
            }

            if (!br.hasErrors()) {
                // 계좌, 지갑 개설 및 연동
                System.out.println("test");
                memberService.accountAndWalletOpening(member, accountAndWalletOpeningDTO);

                // 추천인 이벤트
                boolean eventState = (accountAndWalletOpeningDTO.getReferralCode() != null) ? memberService.event(member.getId(), accountAndWalletOpeningDTO.getReferralCode()) : false;

                // 추천인 이벤트 정상 참여한 경우
                if (eventState) {
                    return ResponseEntity.ok().body("{\"event\" : \"ok\"}");
                } else {
                    return ResponseEntity.ok().build();
                }
            } else {
                // 유효성검사 실패
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("bad request");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("server error");
        }
    }

    /**
     * 개설 완료 리다이렉트
     */
    @GetMapping("/account-opening-complete")
    public String completeAccountOpening() {
        return "/account-opening-complete";
    }

    /**
     * 종합 계좌 개설 프로세스 1
     */
    @GetMapping("/accountOpeningProcess1")
    public String accountOpeningProcess1() {
        return "account-opening-process1";
    }

    /**
     * 종합 계좌 개설 프로세스 2
     */
    @GetMapping("/accountOpeningProcess2")
    public String accountOpeningProcess2() {
        return "account-opening-process2";
    }

    /**
     * CoolSMS 이용 SMS 인증번호 요청
     */
    @GetMapping("/sms")
    public ResponseEntity sendSMS(@RequestParam("phone") String phone, HttpSession session) {
        try {
            // SMS 전송
            memberService.getSmsCertificationNumber(phone, session);
            // 정상 전송됨
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to send SMS");
        }
    }

    /**
     *  사용자 입력 인증코드 검증
     */
    @PostMapping("/sms")
    public ResponseEntity verifySmsCode(@RequestParam("phoneCodeInput") String phoneCodeInput, HttpSession session) {
        // SMS 전송
        if (memberService.isVerifySms(phoneCodeInput, session)) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid SMS code");
        }
    }


}
