package com.hana1piece.estate.model.vo;

import lombok.Data;

@Data
public class PublicationInfoVO {
    private int listingNumber;
    private String subject;
    private String type;
    private String publisher;
    private long volume;
    private long issuePrice;
    private long totalAmount;
    private String startDate;
    private String expirationDate;
    private String firstDividendDate;
    private String dividendCycle;
    private int dividend;
}
