package com.hana1piece.member.controller;

import com.hana1piece.estate.model.mapper.PublicOfferingMapper;
import com.hana1piece.estate.service.EstateService;
import com.hana1piece.estate.service.PublicOfferingService;
import com.hana1piece.member.model.dto.*;
import com.hana1piece.member.model.vo.OneMembersVO;
import com.hana1piece.member.service.MemberService;
import com.hana1piece.member.service.MyPageService;
import com.hana1piece.trading.model.vo.ExecutionVO;
import com.hana1piece.trading.model.vo.ReservationOrdersVO;
import com.hana1piece.trading.model.vo.StoOrdersVO;
import com.hana1piece.trading.service.ReservationOrderService;
import com.hana1piece.wallet.model.dto.DividendDetailsDTO;
import com.hana1piece.wallet.model.vo.*;
import com.hana1piece.wallet.service.DividendService;
import com.hana1piece.wallet.service.WalletService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class MyPageController {

    private final MemberService memberService;
    private final MyPageService myPageService;
    private final WalletService walletService;
    private final DividendService dividendService;
    private final PublicOfferingService publicOfferingService;
    private final ReservationOrderService reservationOrderService;
    private final EstateService estateService;

    @Autowired
    public MyPageController(MemberService memberService, MyPageService myPageService, WalletService walletService, EstateService estateService, PublicOfferingMapper publicOfferingMapper, DividendService dividendService, PublicOfferingService publicOfferingService, ReservationOrderService reservationOrderService, EstateService estateService1) {
        this.memberService = memberService;
        this.myPageService = myPageService;
        this.walletService = walletService;
        this.dividendService = dividendService;
        this.publicOfferingService = publicOfferingService;
        this.reservationOrderService = reservationOrderService;
        this.estateService = estateService1;
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

        if (wallet == null) {
            mav.setViewName("/account-opening");
            return mav;
        }

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
        // 보유 빌딩 정보
        List<MembersStosInfoDTO> membersStosInfoDTOList = myPageService.getMembersStosInfoDTOByWalletNumber(wallet.getWalletNumber());
        mav.addObject("membersStosInfoDTOList", membersStosInfoDTOList);
        // 보유 빌딩 상세 거래내역
        List<StoOrdersVO> stoOrdersVOList = myPageService.getMembersStoOrdersByWalletNumber(wallet.getWalletNumber());
        mav.addObject("stoOrdersVOList", stoOrdersVOList);
        // 총자산
        MembersTotalAssetDTO membersTotalAssetDTO = myPageService.getMembersTotalAsset(wallet.getWalletNumber());
        mav.addObject("membersTotalAssetDTO", membersTotalAssetDTO);
        // 6개월 누적 배당금
        mav.addObject("totalDividendFor6month", dividendService.sumDividendFor6monthByWN(wallet.getWalletNumber()));
        // 배당금 지급 내역
        List<DividendDetailsDTO> dividendDetailsDTOList = dividendService.findByWN(wallet.getWalletNumber());
        mav.addObject("dividendDetailsDTOList", dividendDetailsDTOList);
        // 매각 투표
        List<MembersSellVoteDTO> membersSellVoteDTOList = myPageService.getMembersSellVoteDTOByWalletNumber(wallet.getWalletNumber());
        mav.addObject("membersSellVoteDTOList", membersSellVoteDTOList);
        // 티끌모아 건물주
        List<MembersReservationOrdersDTO> membersReservationOrdersDTOList = new ArrayList<>();
        List<ReservationOrdersVO> reservationOrdersVOList = reservationOrderService.findByWN(wallet.getWalletNumber());
        for (ReservationOrdersVO reservationOrdersVO : reservationOrdersVOList) {
            MembersReservationOrdersDTO membersReservationOrdersDTO = new MembersReservationOrdersDTO();
            membersReservationOrdersDTO.setReservationOrdersVO(reservationOrdersVO);
            membersReservationOrdersDTO.setRealEstateInfoVO(estateService.findRealEstateInfoByLN(reservationOrdersVO.getListingNumber()));
            membersReservationOrdersDTOList.add(membersReservationOrdersDTO);
        }
        mav.addObject("membersReservationOrdersDTOList", membersReservationOrdersDTOList);


        return mav;
    }


}
