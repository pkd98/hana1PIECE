package com.hana1piece.wallet.model.mapper;

import com.hana1piece.wallet.model.vo.DividendDetailsVO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface DividendMapper {

    List<DividendDetailsVO> findAll();

    List<DividendDetailsVO> findByWN(int WN);

    List<DividendDetailsVO> findByLN(int LN);

    void insertDividendDetails(DividendDetailsVO dividendDetailsVO);

}