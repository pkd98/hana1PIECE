package com.hana1piece.estate.model.mapper;

import com.hana1piece.estate.model.vo.SellVoteVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SellVoteMapper {

    void insertSellVote(SellVoteVO sellVoteVO);

    void updateSellVote(SellVoteVO sellVoteVO);

    SellVoteVO findByLNAndWN(@Param("LN") int LN, @Param("WN") int WN);

    long findTotalProsQuantityByLN(int LN);

    long findTotalQuantityByLN(int LN);
}
