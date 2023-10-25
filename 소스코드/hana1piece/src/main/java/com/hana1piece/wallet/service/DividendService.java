package com.hana1piece.wallet.service;

import com.hana1piece.wallet.model.dto.DividendDetailsDTO;
import com.hana1piece.wallet.model.vo.DividendDetailsVO;

import java.util.List;

public interface DividendService {
    List<DividendDetailsVO> findAll();

    List<DividendDetailsDTO> findByWN(int WN);

    List<DividendDetailsVO> findByLN(int LN);

    int sumDividendFor6monthByWN(int WN);

    void insertDividendDetails(DividendDetailsVO dividendDetailsVO);

}
