package com.hana1piece.estate.model.vo;

import lombok.Data;

@Data
public class SoldBuildingVO {
    private int listingNumber;
    private String soldDate;
    private long amount;
    private String startDate;
    private String expirationDate;
    private long dividend;
}
