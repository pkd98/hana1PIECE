package com.hana1piece.trading.model.mapper;

import com.hana1piece.trading.model.vo.StoOrdersVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface StoOrdersMapper {

    List<StoOrdersVO> findAll();

    void insertOrder(StoOrdersVO stoOrdersVO);

    void insertOrderForPublicOffering(StoOrdersVO stoOrdersVO);

    void updateOrder(StoOrdersVO stoOrdersVO);

    List<StoOrdersVO> findBuyOrderDetailByAmountAndLN(@Param("amount")int amount, @Param("LN")int LN);

    List<StoOrdersVO> findSellOrderDetailByAmountAndLN(@Param("amount")int amount, @Param("LN")int LN);

    int getOrderSeqCrrval();
}
