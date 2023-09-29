package com.hana1piece.wallet.model.vo;

import lombok.Data;

@Data
public class DividendDetailsVO {
    private int payoutNumber;
    private long walletNumber;
    private int listingNumber;
    private long payout;
    private String payoutDate;
}