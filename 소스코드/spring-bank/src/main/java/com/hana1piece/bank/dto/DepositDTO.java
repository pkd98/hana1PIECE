package com.hana1piece.bank.dto;

import lombok.Data;

@Data
public class DepositDTO {
    private String accountNumber;
    private long amount;
    private String name; // 거래명
    private String recipientAccountNumber; // 상대 계좌번호
}