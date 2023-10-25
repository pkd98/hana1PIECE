package com.hana1piece.bank.controller;

import com.hana1piece.bank.dto.AccountOpeningDTO;
import com.hana1piece.bank.dto.DepositDTO;
import com.hana1piece.bank.dto.TransferDTO;
import com.hana1piece.bank.dto.WithdrawDTO;
import com.hana1piece.bank.service.BankService;
import com.hana1piece.bank.vo.AccountVO;
import com.hana1piece.bank.vo.BankTransactionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class BankController {
    private final BankService bankService;

    @Autowired
    public BankController(BankService bankService) {
        this.bankService = bankService;
    }

    /**
     * 계좌 조회
     */
    @ResponseBody
    @GetMapping("/account/{accountNumber}")
    public ResponseEntity<Map<String, Object>> getAccount(@PathVariable("accountNumber") String accountNumber) {
        Map<String, Object> responseBody = new HashMap<>();
        AccountVO accountVO = bankService.findAccountByAccountNumber(accountNumber);

        if (accountVO != null) {
            responseBody.put("state", "OK");
            responseBody.put("message", "조회 성공");
            responseBody.put("data", accountVO);
            return ResponseEntity.ok(responseBody);
        } else {
            return ResponseEntity.notFound()
                    .header("state", "error")
                    .header("message", "Account not found.")
                    .build();
        }
    }

    /**
     * 거래내역 조회
     */
    @ResponseBody
    @GetMapping("/bankTransaction/{accountNumber}")
    public ResponseEntity<Map<String, Object>> getBankTransaction(@PathVariable("accountNumber") String accountNumber) {
        Map<String, Object> responseBody = new HashMap<>();
        List<BankTransactionVO> bankTransactionVOList = bankService.findBankTransactionByAccountNumber(accountNumber);
        if (!bankTransactionVOList.isEmpty()) {
            responseBody.put("state", "OK");
            responseBody.put("message", "조회 성공");
            responseBody.put("data", bankTransactionVOList);
            return ResponseEntity.ok(responseBody);
        } else {
            return ResponseEntity.notFound()
                    .header("state", "error")
                    .header("message", "Account not found.")
                    .build();
        }
    }

    /**
     * 계좌 개설
     */
    @ResponseBody
    @PostMapping("/account/opening")
    public String accountOpening(@RequestBody AccountOpeningDTO accountOpeningDTO) {
        // System.out.println(accountOpeningDTO.toString());
        // 개설된 계좌번호 리턴
        return bankService.accountOpening(accountOpeningDTO);
    }


    /**
     * 계좌 입금
     */
    @ResponseBody
    @PutMapping("/deposit")
    public void deposit(@RequestBody DepositDTO depositDTO) {
        // System.out.println(depositDTO.toString());
        bankService.deposit(depositDTO);
    }

    /**
     * 계좌 출금
     */
    @ResponseBody
    @PutMapping("/withdraw")
    public void withdraw(@RequestBody WithdrawDTO withdrawDTO) {
        // System.out.println(withdrawDTO.toString());
        bankService.withdraw(withdrawDTO);
    }

    /**
     * 계좌 이체
     */
    @ResponseBody
    @PutMapping("/transfer")
    public void transfer(@RequestBody TransferDTO transferDTO) {
        System.out.println(transferDTO.toString());
        bankService.transfer(transferDTO);
    }

}
