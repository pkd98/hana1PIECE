package com.hana1piece.estate.controller;

import com.hana1piece.estate.model.dto.PublicOfferingListDTO;
import com.hana1piece.estate.service.EstateService;
import com.hana1piece.member.model.vo.OneMembersVO;
import com.hana1piece.wallet.model.vo.WalletVO;
import com.hana1piece.wallet.service.WalletService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class EstateController {
    private final EstateService estateService;
    private final WalletService walletService;

    @Autowired
    public EstateController(EstateService estateService, WalletService walletService) {
        this.estateService = estateService;
        this.walletService = walletService;
    }

    @GetMapping("/estate-list")
    public ModelAndView estateList() {
        ModelAndView mav = new ModelAndView("estate-list");
        // mav.addObject(estateService.findRe)
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
    public ModelAndView publicOfferingDetails(@PathVariable String LN, HttpSession session) {
        ModelAndView mav = new ModelAndView("public-offering-details");
        OneMembersVO member = (OneMembersVO) session.getAttribute("member");
        // 세션 만료 리턴
        if (member == null) {
            mav.setViewName("redirect:/");
            return mav;
        }
        mav.addObject("wallet", walletService.findWalletByMemberId(member.getId()));
        mav.addObject("realEstateInfo", estateService.findRealEstateInfoByLN(Integer.parseInt(LN)));
        mav.addObject("publicationInfo", estateService.findPublicationInfoByLN(Integer.parseInt(LN)));
        mav.addObject("tenantInfo", estateService.findTenantInfoByLN(Integer.parseInt(LN)));
        return mav;
    }


}
