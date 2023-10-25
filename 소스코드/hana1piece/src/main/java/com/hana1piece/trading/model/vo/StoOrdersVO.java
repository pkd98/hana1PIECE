package com.hana1piece.trading.model.vo;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;

@Data
public class StoOrdersVO {
    private int orderId;
    @Min(1)
    private int listingNumber;
    private int walletNumber;
    @NotEmpty
    private String orderType;
    @Min(1)
    private int amount;
    @Min(1)
    private int quantity;
    @Value("N") // 기본값을 "N"으로 설정
    private String status;
    private String orderDate;
    private int executedPriceAvg;
    private int executedQuantity;
}
