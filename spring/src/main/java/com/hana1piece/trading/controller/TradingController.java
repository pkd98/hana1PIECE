package com.hana1piece.trading.controller;

import com.hana1piece.estate.model.vo.RealEstateSaleVO;
import com.hana1piece.estate.service.EstateService;
import com.hana1piece.member.model.vo.OneMembersVO;
import com.hana1piece.trading.model.dto.OrderRequestDTO;
import com.hana1piece.trading.model.dto.ReservationOrderRequestDTO;
import com.hana1piece.trading.model.dto.ReservationTerminateRequestDTO;
import com.hana1piece.trading.model.vo.ReservationOrdersVO;
import com.hana1piece.trading.model.vo.StoOrdersVO;
import com.hana1piece.trading.service.OrderMatchingService;
import com.hana1piece.trading.service.ReservationOrderService;
import com.hana1piece.wallet.model.vo.WalletVO;
import com.hana1piece.wallet.service.StosService;
import com.hana1piece.wallet.service.WalletService;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

@Controller
public class TradingController {

    private final OrderMatchingService orderMatchingService;
    private final WalletService walletService;
    private final StosService stosService;
    private final ReservationOrderService reservationOrderService;
    private final EstateService estateService;

    public TradingController(OrderMatchingService orderMatchingService, WalletService walletService, StosService stosService, ReservationOrderService reservationOrderService, EstateService estateService) {
        this.orderMatchingService = orderMatchingService;
        this.walletService = walletService;
        this.stosService = stosService;
        this.reservationOrderService = reservationOrderService;
        this.estateService = estateService;
    }

    @PostMapping("/order")
    public ResponseEntity tradingOrder(@Valid @RequestBody OrderRequestDTO requestDTO, BindingResult br, HttpSession session) {
        System.out.println(requestDTO.toString());
        System.out.println(requestDTO.getWalletPassword());
        if (br.hasErrors()) {
            return ResponseEntity.badRequest().body("Validation failed: " + br.getAllErrors());
        }
        OneMembersVO member = (OneMembersVO) session.getAttribute("member");
        // 세션 만료 리턴
        if (member == null) {
            return ResponseEntity.badRequest().build();
        }
        try {
            WalletVO wallet = walletService.findWalletByMemberId(member.getId());

            // 지갑 비밀번호 틀림
            if (!wallet.getPassword().equals(requestDTO.getWalletPassword())) {
                return ResponseEntity.badRequest().build();
            }

            StoOrdersVO order = requestDTO.getStoOrdersVO();

            if(order.getOrderType().equals("BUY")){
                // 잔액 부족
                if((long) order.getAmount() * (long )order.getQuantity() > wallet.getBalance()) {
                    return ResponseEntity.badRequest().build();
                }
            }
            else if(order.getOrderType().equals("SELL")){
                // 토큰 부족
                if(stosService.findStosByWalletNumberAndListingNumber(wallet.getWalletNumber(), order.getListingNumber()).getAmount() < order.getQuantity()) {
                    return ResponseEntity.badRequest().build();
                }
            } else {
                // 잘못된 주문
                return ResponseEntity.badRequest().build();
            }

            // 주문정보에 지갑 아이디 등록
            order.setWalletNumber(wallet.getWalletNumber());

            // 주문 로직 처리
            orderMatchingService.processOrder(order);

            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    @PostMapping("/reservation-order")
    public ResponseEntity reservationOrder(@Valid @RequestBody ReservationOrderRequestDTO reservationOrderRequestDTO, BindingResult br, HttpSession session) {
        if(br.hasErrors()) {
            return ResponseEntity.badRequest().body("Validation failed: " + br.getAllErrors());
        }
        OneMembersVO member = (OneMembersVO) session.getAttribute("member");
        // 세션 만료 리턴
        if (member == null) {
            return ResponseEntity.badRequest().build();
        }
        try {
            WalletVO wallet = walletService.findWalletByMemberId(member.getId());
            if(!wallet.getPassword().equals(reservationOrderRequestDTO.getWalletPassword())) {
                return ResponseEntity.badRequest().build();
            }
            reservationOrderService.insertReservation(reservationOrderRequestDTO.getReservationOrdersVO());
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    @PutMapping("/reservation-terminate")
    public ResponseEntity terminateReservation(@RequestBody ReservationTerminateRequestDTO request, HttpSession session) {
        OneMembersVO member = (OneMembersVO) session.getAttribute("member");
        // 세션 만료 리턴
        if (member == null) {
            return ResponseEntity.badRequest().build();
        }
        try {
            ReservationOrdersVO reservationOrdersVO = reservationOrderService.findById(request.getId());
            reservationOrdersVO.setTerminationDate("Terminated");
            reservationOrdersVO.setStatus("T");
            reservationOrderService.updateReservation(reservationOrdersVO);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    /**
     *  오전 9시에 예약 주문 실행
     */
    @Scheduled(cron = "0 0 9 * * ?")
    public void orderForReservation() {
        try {
            List<ReservationOrdersVO> reservationOrdersVOList = reservationOrderService.findAll();

            for(ReservationOrdersVO reservationOrdersVO : reservationOrdersVOList) {
                WalletVO wallet = walletService.findWalletByWN(reservationOrdersVO.getWalletNumber());
                RealEstateSaleVO estate = estateService.findRealEstateSaleByLN(reservationOrdersVO.getListingNumber());

                // 잔액 부족 예약 주문 취소
                if(wallet.getBalance() < reservationOrdersVO.getQuantity() * estate.getPrice()) {
                    reservationOrdersVO.setTerminationDate("Terminated");
                    reservationOrdersVO.setStatus("T");
                    reservationOrderService.updateReservation(reservationOrdersVO);
                    continue;
                } else {
                    // 주문 등록 처리
                    StoOrdersVO order = new StoOrdersVO();
                    order.setWalletNumber(reservationOrdersVO.getWalletNumber());
                    order.setListingNumber(reservationOrdersVO.getListingNumber());
                    order.setQuantity(reservationOrdersVO.getQuantity());
                    order.setAmount((int) estate.getPrice());
                    order.setOrderType("BUY");

                    // 주문 로직 처리
                    orderMatchingService.processOrder(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}