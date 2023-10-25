package com.hana1piece.manager.model.dto;

import lombok.Data;

@Data
public class TransactionStatusDTO {
    private long deposit; // 예수금
    private long transactionAmount; // 거래 대금
}
