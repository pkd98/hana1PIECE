package com.hana1piece.trading.model.dto;

import com.hana1piece.trading.model.vo.OrderBookVO;
import lombok.Data;

import java.util.List;

@Data
public class OrderBookWrapperDTO {
    private List<OrderBookVO> sellOrderBooks;
    private List<OrderBookVO> buyOrderBooks;
}
