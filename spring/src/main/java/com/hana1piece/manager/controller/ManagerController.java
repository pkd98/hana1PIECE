package com.hana1piece.manager.controller;

import com.hana1piece.estate.model.vo.SoldBuildingVO;
import com.hana1piece.estate.service.EstateService;
import com.hana1piece.manager.model.dto.AppNotificationDTO;
import com.hana1piece.manager.model.dto.DividendPaymentDTO;
import com.hana1piece.manager.model.dto.ManagerLoginDTO;
import com.hana1piece.manager.model.dto.PublicOfferingRegistrationDTO;
import com.hana1piece.manager.model.vo.ManagerVO;
import com.hana1piece.manager.service.FirebaseService;
import com.hana1piece.manager.service.ManagerService;
import com.hana1piece.trading.model.vo.ExecutionVO;
import com.hana1piece.trading.model.vo.StoOrdersVO;
import com.hana1piece.wallet.model.vo.DividendDetailsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ManagerController {
    private final ManagerService managerService;
    private final EstateService estateService;
    private final FirebaseService firebaseService;
    private final int itemsPerPage = 10;


    @Autowired
    public ManagerController(ManagerService managerService, EstateService estateService, FirebaseService firebaseService) {
        this.managerService = managerService;
        this.estateService = estateService;
        this.firebaseService = firebaseService;
    }

    @GetMapping("/manager")
    public ModelAndView managerIndex(HttpSession session) {
        ModelAndView mav = new ModelAndView();
        ManagerVO manager = (ManagerVO) session.getAttribute("manager");
        String view = (manager == null) ? "manager-login" : "manager";
        mav.addObject("findPublicOfferingList", estateService.findPublicOfferingListDTO());
        mav.addObject("listedEstateList", estateService.findListedEstateListDTO());
        mav.addObject("transactionStatus", managerService.getTransactionStatus());
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

    /**
     *  배당금 지급
     */
    @PutMapping("/manager/dividend-payment")
    public ResponseEntity dividend(@Valid @RequestBody DividendPaymentDTO dividendPaymentDTO) {
        try {
            managerService.dividendPaymentUsingProcedure(dividendPaymentDTO);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("error");
        }
    }

    /**
     *  매각 투표 등록
     */
    @PostMapping("/manager/sale-vote")
    public ResponseEntity registerToVote(@Valid @RequestBody SoldBuildingVO soldBuildingVO) {
        try {
            System.out.println(soldBuildingVO.toString());
            managerService.registerSaleVote(soldBuildingVO);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("error");
        }
    }

    /**
     *  앱 푸시 알림 보내기
     */
    @PostMapping("/manager/app-notification")
    public ResponseEntity transmitPushAppNotification(@RequestBody AppNotificationDTO appNotificationDTO) {
        try {
            System.out.println(appNotificationDTO);
            firebaseService.transmitPushAppNotification(appNotificationDTO);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("error");
        }
    }


    /**
     *  주문 내역
     */
    @GetMapping("/manager/orders")
    @ResponseBody
    public Map<String, Object> getOrdersByPage(@RequestParam int page) {
        int totalCount = managerService.getTotalOrderCount(); // 전체 데이터의 개수를 조회
        int totalPages = (int) Math.ceil((double) totalCount / itemsPerPage); // 전체 페이지 수 계산

        List<StoOrdersVO> orders = managerService.getOrdersByPage(page);
        Map<String, Object> response = new HashMap<>();
        response.put("orders", orders);
        response.put("currentPage", page); // 현재 페이지 번호
        response.put("totalPages", totalPages); // 전체 페이지 수
        return response;
    }

    /**
     *  체결 내역
     */
    @GetMapping("/manager/executions")
    @ResponseBody
    public Map<String, Object> getExecutionsByPage(@RequestParam int page) {
        int totalCount = managerService.getTotalExecutionCount(); // 전체 데이터의 개수를 조회
        int totalPages = (int) Math.ceil((double) totalCount / itemsPerPage); // 전체 페이지 수 계산

        List<ExecutionVO> executions = managerService.getExecutionsByPage(page);
        Map<String, Object> response = new HashMap<>();
        response.put("executions", executions);
        response.put("currentPage", page); // 현재 페이지 번호
        response.put("totalPages", totalPages); // 전체 페이지 수
        return response;
    }


    /**
     *  배당금 지급 내역
     */
    @GetMapping("/manager/payments")
    @ResponseBody
    public Map<String, Object> getPaymentsByPage(@RequestParam int page) {
        int totalCount = managerService.getTotalPaymentCount(); // 전체 데이터의 개수를 조회
        int totalPages = (int) Math.ceil((double) totalCount / itemsPerPage); // 전체 페이지 수 계산

        List<DividendDetailsVO> payments = managerService.getDividendDetailsByPage(page);
        Map<String, Object> response = new HashMap<>();
        response.put("payments", payments);
        response.put("currentPage", page); // 현재 페이지 번호
        response.put("totalPages", totalPages); // 전체 페이지 수
        return response;
    }



}
