package com.hana1piece.trading.model.vo;

import lombok.Data;

import javax.validation.constraints.Min;

@Data
public class ReservationOrdersVO {
    private int id;
    @Min(1)
    private int listingNumber;
    @Min(1)
    private int walletNumber;
    @Min(1)
    private int quantity;
    private String status;
    private String orderDate;
    private String terminationDate;
}
