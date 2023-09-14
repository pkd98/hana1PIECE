package com.hana1piece.trading.model.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderBookMapper {

    void init(int listingNumber);

}
