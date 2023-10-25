package com.hana1piece.trading.model.vo;

import lombok.Data;

@Data
public class ExecutionVO {
    private int executionId;
    private int buyOrderId;
    private int sellOrderId;
    private int executedPrice;
    private int executedQuantity;
    private String executionDate;
}
