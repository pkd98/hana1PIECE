package com.hana1piece.trading.service;

import com.hana1piece.trading.model.mapper.OrderBookMapper;
import com.hana1piece.trading.model.vo.OrderBookVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderBookServiceImpl implements OrderBookService {

    private final OrderBookMapper orderBookMapper;

    @Autowired
    public OrderBookServiceImpl(OrderBookMapper orderBookMapper) {
        this.orderBookMapper = orderBookMapper;
    }

    @Override
    public List<OrderBookVO> findOrderBookListByLN(int LN) {
        return orderBookMapper.findOrderBookListByLN(LN);
    }

    @Override
    public List<OrderBookVO> findSellOrderBookListByLN(int LN) {
        return orderBookMapper.findSellOrderBookListByLN(LN);
    }

    @Override
    public List<OrderBookVO> findBuyOrderBookListByLN(int LN) {
        return orderBookMapper.findBuyOrderBookListByLN(LN);
    }
}
