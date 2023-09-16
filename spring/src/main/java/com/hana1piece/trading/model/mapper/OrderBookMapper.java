package com.hana1piece.trading.model.mapper;

import com.hana1piece.trading.model.vo.OrderBookVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OrderBookMapper {

    void init(int listingNumber);

    List<OrderBookVO> findOrderBookListByLN(int LN);
    List<OrderBookVO> findSellOrderBookListByLN(int LN);
    List<OrderBookVO> findBuyOrderBookListByLN(int LN);

}
