package com.hana1piece.member.controller;

import com.hana1piece.member.model.dto.SignupDTO;
import com.hana1piece.member.service.MemberService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.validation.Errors;

import javax.validation.Valid;

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
     *  회원 가입
     */
    @PostMapping("/signup")
    public ResponseEntity signup(@Valid @RequestBody SignupDTO signupDTO, BindingResult bindingResult) {
        System.out.println(signupDTO.toString());
        /**
         *  유효성 검사 실패
         */
        if(bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body("Validation failed: " + bindingResult.getAllErrors());
        }
        try {
            /**
             * 정상 회원가입 성공
             */
            memberService.signup(signupDTO);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            /**
             *  회원가입 실패
             */
            return ResponseEntity.badRequest().build();
        }
    }


}
