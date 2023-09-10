package com.hana1piece.member.controller;

import com.hana1piece.member.service.MemberService;
import com.hana1piece.member.service.MyPageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MyPageController {

    private final MemberService memberService;
    private final MyPageService myPageService;

    @Autowired
    public MyPageController(MemberService memberService, MyPageService myPageService) {
        this.memberService = memberService;
        this.myPageService = myPageService;
    }

    @GetMapping("/mypage")
    public String mypage() {
        return "/mypage";
    }


}
