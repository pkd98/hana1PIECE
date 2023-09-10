package com.hana1piece.wallet.controller;

import com.hana1piece.member.model.vo.OneMembersVO;
import com.hana1piece.wallet.model.dto.DepositDTO;
import com.hana1piece.wallet.model.dto.WithdrawDTO;
import com.hana1piece.wallet.service.WalletService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PutMapping;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
public class WalletController {

    private final WalletService walletService;

    @Autowired
    public WalletController(WalletService walletService) {
        this.walletService = walletService;
    }

    /**
     * 입금 신청
     */
    @PutMapping("/deposit")
    public ResponseEntity deposit(@Valid DepositDTO depositDTO, BindingResult br, HttpSession session) {
        try {
            OneMembersVO member = (OneMembersVO) session.getAttribute("member");
            // 세션 만료 리턴
            if (member == null) {
                return null;
            }

            if (!br.hasErrors()) {
                // 입금 서비스 로직
                walletService.walletDeposit(member, depositDTO);

                // 정상 입금 성공
                return ResponseEntity.ok().build();
            } else {
                // 유효성검사 실패
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("bad request");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("server error");
        }
    }

    /**
     * 출금 신청
     */
    @PutMapping("/withdraw")
    public ResponseEntity withdraw(WithdrawDTO withdrawDTO, BindingResult br, HttpSession session) {
        try {
            OneMembersVO member = (OneMembersVO) session.getAttribute("member");
            // 세션 만료 리턴
            if (member == null) {
                return null;
            }

            if (!br.hasErrors()) {
                // 출금 서비스 로직
                walletService.walletWithdraw(member, withdrawDTO);

                // 정상 출금 성공
                return ResponseEntity.ok().build();
            } else {
                // 유효성검사 실패
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("bad request");
            }

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("server error");
        }
    }


}
