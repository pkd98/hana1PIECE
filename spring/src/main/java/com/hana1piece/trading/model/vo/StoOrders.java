package com.hana1piece.trading.model.vo;

import lombok.Data;

@Data
public class StoOrders {
    private int orderId;
    private int listingNumber;
    private int walletNumber;
    private String orderType;
    private int amount;
    private int quantity;
    private String status;
    private String orderDate;
}
