package com.hana1piece.member.model.vo;

import lombok.Data;

@Data
public class BankTransactionVO {
    private int transactionNumber;
    private String accountNumber;
    private String classification;
    private String name;
    private long amount;
    private long balance;
    private String bankCode;
    private String recipientAccountNumber;
    private String transactionDate; // TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')
}
