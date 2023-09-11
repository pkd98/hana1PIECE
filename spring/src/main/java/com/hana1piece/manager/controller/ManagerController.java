package com.hana1piece.manager.controller;

import com.hana1piece.manager.model.dto.ManagerLoginDTO;
import com.hana1piece.manager.model.vo.ManagerVO;
import com.hana1piece.manager.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
public class ManagerController {

    private final ManagerService managerService;

    @Autowired
    public ManagerController(ManagerService managerService) {
        this.managerService = managerService;
    }

    @GetMapping("/manager")
    public String managerIndex(HttpSession session) {
        ManagerVO manager = (ManagerVO) session.getAttribute("manager");
        return (manager == null) ? "manager-login" : "manager";
    }
    @PostMapping("/manager/login")
    @ResponseBody
    public String manager(@Valid @RequestBody ManagerLoginDTO loginDTO, Errors errors, BindingResult bindingResult, HttpSession session) {
        try {
            String redirectName = "";
            System.out.println(loginDTO.toString());
            // 잘못된 접근
            if (bindingResult.hasErrors()) {
                redirectName = "manager/login";
            }
            // 로그인 서비스
            if (managerService.login(loginDTO, session)) {
                // 로그인 성공
                redirectName = "manager";
            } else {
                // 아이디 비밀번호 불일치 리다이렉트
                redirectName = "manager/login";
            }
            return redirectName;
        } catch (Exception e) {
            return "manager/login";
        }
    }

    @GetMapping("/manager/login")
    String manager() {
        return "manager-login";
    }

    /**
     * 로그아웃
     */
    @GetMapping("/manager/logout")
    public String signout(HttpSession session) {
        session.removeAttribute("manager");
        return "redirect:/manager";
    }


}
