package com.hana1piece.manager.controller;

import com.hana1piece.estate.service.EstateService;
import com.hana1piece.manager.model.dto.ManagerLoginDTO;
import com.hana1piece.manager.model.dto.PublicOfferingRegistrationDTO;
import com.hana1piece.manager.model.vo.ManagerVO;
import com.hana1piece.manager.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
public class ManagerController {
    private final ManagerService managerService;
    private final EstateService estateService;

    @Autowired
    public ManagerController(ManagerService managerService, EstateService estateService) {
        this.managerService = managerService;
        this.estateService = estateService;
    }

    @GetMapping("/manager")
    public ModelAndView managerIndex(HttpSession session) {
        ModelAndView mav = new ModelAndView();
        ManagerVO manager = (ManagerVO) session.getAttribute("manager");
        String view = (manager == null) ? "manager-login" : "manager";
        mav.addObject("findPublicOfferingList", estateService.findPublicOfferingListDTO());
        mav.setViewName(view);
        return mav;
    }

    /**
     * 관리자 로그인
     */
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

    /**
     *  청약 공모 등록
     */
    @PostMapping("/manager/public-offering/registration")
    public ResponseEntity publicOfferingRegistration(@ModelAttribute PublicOfferingRegistrationDTO publicOfferingRegistrationDTO) {
        try {
            // 서비스 로직 처리
            managerService.publicOfferingRegistration(publicOfferingRegistrationDTO);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("error");
        }
    }

    /**
     *  매물 상장
     */
    @PutMapping("/manager/estate-listing")
    public ResponseEntity estateListing(@RequestParam int listingNumber) {
        try {
            managerService.estateListing(listingNumber);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("error");
        }
    }

}
