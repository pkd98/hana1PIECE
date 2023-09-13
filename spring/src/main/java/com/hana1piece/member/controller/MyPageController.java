package com.hana1piece.member.controller;

import com.hana1piece.estate.model.mapper.PublicOfferingMapper;
import com.hana1piece.estate.service.EstateService;
import com.hana1piece.estate.service.PublicOfferingService;
import com.hana1piece.member.model.dto.MembersOrderPublicOfferingDTO;
import com.hana1piece.member.model.vo.OneMembersVO;
import com.hana1piece.member.service.MemberService;
import com.hana1piece.member.service.MyPageService;
import com.hana1piece.wallet.model.vo.AccountVO;
import com.hana1piece.wallet.model.vo.BankTransactionVO;
import com.hana1piece.wallet.model.vo.WalletTransactionVO;
import com.hana1piece.wallet.model.vo.WalletVO;
import com.hana1piece.wallet.service.WalletService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class MyPageController {

    private final MemberService memberService;
    private final MyPageService myPageService;
    private final WalletService walletService;
    private final PublicOfferingService publicOfferingService;

    @Autowired
    public MyPageController(MemberService memberService, MyPageService myPageService, WalletService walletService, EstateService estateService, PublicOfferingMapper publicOfferingMapper, PublicOfferingService publicOfferingService) {
        this.memberService = memberService;
        this.myPageService = myPageService;
        this.walletService = walletService;
        this.publicOfferingService = publicOfferingService;
    }

    @GetMapping("/mypage")
    public ModelAndView mypage(HttpSession session) {
        ModelAndView mav = new ModelAndView("/mypage");
        OneMembersVO member = (OneMembersVO) session.getAttribute("member");

        // 세션 만료 리턴
        if (member == null) {
            mav.setViewName("/index");
            return mav;
        }
        // 사용자 지갑
        WalletVO wallet = walletService.findWalletByMemberId(member.getId());
        mav.addObject("wallet", wallet);
        // 지갑 거래 내역
        List<WalletTransactionVO> walletTransactionList = walletService.findWalletTransactionByWalletNumber(wallet.getWalletNumber());
        mav.addObject("walletTransactionList", walletTransactionList);
        // 은행 계좌
        AccountVO account = walletService.requestBankAccount(wallet.getAccountNumber());
        mav.addObject("account", account);
        // 은행 계좌 내역
        List<BankTransactionVO> bankTransactionList = walletService.requestBankAccountTransaction(wallet.getAccountNumber());
        mav.addObject("bankTransactionList", bankTransactionList);
        // 청약 신청 내역
        List<MembersOrderPublicOfferingDTO> membersOrderPublicOfferingDTOList = publicOfferingService.findMembersOrderPublicationOfferingByWalletNumber(wallet.getWalletNumber());
        mav.addObject("membersOrderPublicOfferingDTOList", membersOrderPublicOfferingDTOList);

        /*
        System.out.println(wallet.toString());
        walletTransactionList.stream().forEach(System.out::println);
        System.out.println(account.toString());
        bankTransactionList.stream().forEach(System.out::println);
        */
        return mav;
    }


}
