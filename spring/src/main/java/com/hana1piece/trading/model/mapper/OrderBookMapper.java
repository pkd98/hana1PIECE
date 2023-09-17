package com.hana1piece.trading.model.mapper;

import com.hana1piece.trading.model.vo.OrderBookVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OrderBookMapper {

    /**
     * 30 호가씩 셋팅
     * @param listingNumber
     */
    void init(int listingNumber);

    List<OrderBookVO> findOrderBookListByLN(int LN);
    List<OrderBookVO> findSellOrderBookListByLN(int LN);
    List<OrderBookVO> findBuyOrderBookListByLN(int LN);

    /**
     * 수량 업데이트
     */
    void updateAmount(OrderBookVO orderBookVO);

    /**
     * 호가 등록
     */
    void insertOrderBook(OrderBookVO orderBookVO);

    /**
     *  특정 호가 검색
     */
    OrderBookVO findOrderBookByLNAndPriceAndType(@Param("LN") int LN, @Param("price") int price, @Param("type") String type);



}
