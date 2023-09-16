package com.hana1piece.trading.model.vo;

import lombok.Data;

@Data
public class Execution {
    private int executionId;
    private int orderId;
    private int executedPrice;
    private int quantity;
    private String executionDate;
}
