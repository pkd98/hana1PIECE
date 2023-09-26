package com.hana1piece.wallet.model.dto;

import lombok.Data;

@Data
public class DividendDetailsDTO {
    private int payoutNumber;
    private int walletNumber;
    private int listingNumber;
    private String buildingName;
    private long payout;
    private String payoutDate;
}
