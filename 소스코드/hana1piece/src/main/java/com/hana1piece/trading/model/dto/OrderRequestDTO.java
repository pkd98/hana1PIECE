package com.hana1piece.trading.model.dto;

import com.hana1piece.trading.model.vo.StoOrdersVO;
import lombok.Data;

import javax.validation.Valid;

@Data
public class OrderRequestDTO {
    @Valid
    private StoOrdersVO stoOrdersVO;
    private String walletPassword;
}
