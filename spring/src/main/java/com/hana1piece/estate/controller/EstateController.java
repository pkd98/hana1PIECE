package com.hana1piece.estate.controller;

import com.hana1piece.estate.model.dto.OrderPublicOfferingDTO;
import com.hana1piece.estate.model.dto.PublicOfferingListDTO;
import com.hana1piece.estate.service.EstateService;
import com.hana1piece.estate.service.PublicOfferingService;
import com.hana1piece.member.model.vo.OneMembersVO;
import com.hana1piece.wallet.service.WalletService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

@Controller
public class EstateController {
    private final EstateService estateService;
    private final WalletService walletService;
    private final PublicOfferingService publicOfferingService;

    @Autowired
    public EstateController(EstateService estateService, WalletService walletService, PublicOfferingService publicOfferingService) {
        this.estateService = estateService;
        this.walletService = walletService;
        this.publicOfferingService = publicOfferingService;
    }

    /**
     * 매물 리스트 페이지
     */
    @GetMapping("/estate-list")
    public ModelAndView estateList() {
        ModelAndView mav = new ModelAndView("estate-list");
        mav.addObject("listedEstateList", estateService.findListedEstateListDTO());
        return mav;
    }

    /**
     * 매물 상세 페이지
     */
    @GetMapping("/estate-list/{LN}")
    public ModelAndView estateDetails(@PathVariable int LN, HttpSession session) {
        ModelAndView mav = new ModelAndView("estate-details");
        OneMembersVO member = (OneMembersVO) session.getAttribute("member");
        // 세션 만료 리턴
        if (member == null) {
            mav.setViewName("redirect:/");
            return mav;
        }
        mav.addObject("wallet", walletService.findWalletByMemberId(member.getId()));
        mav.addObject("realEstateSale", estateService.findRealEstateSaleByLN(LN));
        mav.addObject("realEstateInfo", estateService.findRealEstateInfoByLN(LN));
        mav.addObject("publicationInfo", estateService.findPublicationInfoByLN(LN));
        mav.addObject("tenantInfo", estateService.findTenantInfoByLN(LN));
        mav.addObject("publicOfferingProgress", publicOfferingService.findPublicOfferingProgressByListingNumber(LN));
        return mav;
    }

    /**
     * 매물 거래 페이지
     */
    @GetMapping("/estate-trading/{LN}")
    public ModelAndView estateTrading(@PathVariable int LN, HttpSession session) {
        ModelAndView mav = new ModelAndView("estate-trading");
        OneMembersVO member = (OneMembersVO) session.getAttribute("member");
        // 세션 만료 리턴
        if (member == null) {
            mav.setViewName("redirect:/");
            return mav;
        }
        mav.addObject("wallet", walletService.findWalletByMemberId(member.getId()));
        mav.addObject("realEstateSale", estateService.findRealEstateSaleByLN(LN));
        mav.addObject("realEstateInfo", estateService.findRealEstateInfoByLN(LN));
        mav.addObject("publicationInfo", estateService.findPublicationInfoByLN(LN));
        mav.addObject("tenantInfo", estateService.findTenantInfoByLN(LN));
        mav.addObject("publicOfferingProgress", publicOfferingService.findPublicOfferingProgressByListingNumber(LN));
        return mav;
    }

    /**
     * 청약 리스트 페이지
     */
    @GetMapping("/public-offering")
    public ModelAndView publicOfferingList() {
        ModelAndView mav = new ModelAndView("public-offering-list");
        List<PublicOfferingListDTO> publicOfferingListDTOList = estateService.findPublicOfferingListDTO();
        mav.addObject("publicOfferingList", publicOfferingListDTOList);
        return mav;
    }

    /**
     * 청약 상세 페이지
     */
    @GetMapping("/public-offering/{LN}")
    public ModelAndView publicOfferingDetails(@PathVariable int LN, HttpSession session) {
        ModelAndView mav = new ModelAndView("public-offering-details");
        OneMembersVO member = (OneMembersVO) session.getAttribute("member");
        // 세션 만료 리턴
        if (member == null) {
            mav.setViewName("redirect:/");
            return mav;
        }
        mav.addObject("wallet", walletService.findWalletByMemberId(member.getId()));
        mav.addObject("realEstateInfo", estateService.findRealEstateInfoByLN(LN));
        mav.addObject("publicationInfo", estateService.findPublicationInfoByLN(LN));
        mav.addObject("tenantInfo", estateService.findTenantInfoByLN(LN));
        mav.addObject("publicOfferingProgress", publicOfferingService.findPublicOfferingProgressByListingNumber(LN));
        return mav;
    }

    /**
     *  사용자 청약 주문 처리
     */
    @PostMapping("/public-offering")
    public ResponseEntity orderPublicOffering(@Valid @RequestBody OrderPublicOfferingDTO orderPublicOfferingDTO, BindingResult br, HttpSession session) {
        System.out.println(orderPublicOfferingDTO.toString());
        if(br.hasErrors()) {
            return ResponseEntity.badRequest().body("Validation failed: " + br.getAllErrors());
        }
        OneMembersVO member = (OneMembersVO) session.getAttribute("member");
        // 세션 만료 리턴
        if (member == null) {
            return ResponseEntity.badRequest().build();
        }
        try {
            // 청약 신청 서비스
            publicOfferingService.order(orderPublicOfferingDTO);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }


}
