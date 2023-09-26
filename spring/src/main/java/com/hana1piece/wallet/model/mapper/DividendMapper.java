package com.hana1piece.wallet.model.mapper;

import com.hana1piece.wallet.model.dto.DividendDetailsDTO;
import com.hana1piece.wallet.model.vo.DividendDetailsVO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface DividendMapper {

    List<DividendDetailsVO> findAll();

    List<DividendDetailsDTO> findByWN(int WN);

    List<DividendDetailsVO> findByLN(int LN);

    int sumDividendFor6monthByWN(int WN);

    void insertDividendDetails(DividendDetailsVO dividendDetailsVO);

}