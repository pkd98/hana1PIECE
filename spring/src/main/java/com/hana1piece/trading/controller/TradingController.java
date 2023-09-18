package com.hana1piece.trading.controller;

import com.hana1piece.member.model.vo.OneMembersVO;
import com.hana1piece.trading.model.dto.OrderRequestDTO;
import com.hana1piece.trading.model.vo.StoOrdersVO;
import com.hana1piece.trading.service.OrderMatchingService;
import com.hana1piece.wallet.model.vo.WalletVO;
import com.hana1piece.wallet.service.StosService;
import com.hana1piece.wallet.service.WalletService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
public class TradingController {

    private final OrderMatchingService orderMatchingService;
    private final WalletService walletService;
    private final StosService stosService;

    public TradingController(OrderMatchingService orderMatchingService, WalletService walletService, StosService stosService) {
        this.orderMatchingService = orderMatchingService;
        this.walletService = walletService;
        this.stosService = stosService;
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
}