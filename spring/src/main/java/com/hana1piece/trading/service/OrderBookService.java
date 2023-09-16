package com.hana1piece.trading.service;

import com.hana1piece.trading.model.vo.OrderBookVO;

import java.util.List;

public interface OrderBookService {
    List<OrderBookVO> findOrderBookListByLN(int LN);
    List<OrderBookVO> findSellOrderBookListByLN(int LN);
    List<OrderBookVO> findBuyOrderBookListByLN(int LN);

}
