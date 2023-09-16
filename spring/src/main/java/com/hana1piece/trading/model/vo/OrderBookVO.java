package com.hana1piece.trading.model.vo;

import lombok.Data;

@Data
public class OrderBookVO {
    private int id;
    private int listingNumber;
    private String type;
    private int price;
    private int amount;
}
