package com.hana1piece.wallet.service;

import com.hana1piece.wallet.model.dto.DividendDetailsDTO;
import com.hana1piece.wallet.model.mapper.DividendMapper;
import com.hana1piece.wallet.model.vo.DividendDetailsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DividendServiceImpl implements DividendService {

    private final DividendMapper dividendMapper;

    @Autowired
    public DividendServiceImpl(DividendMapper dividendMapper) {
        this.dividendMapper = dividendMapper;
    }

    @Override
    public List<DividendDetailsVO> findAll() {
        return dividendMapper.findAll();
    }

    @Override
    public List<DividendDetailsDTO> findByWN(int WN) {
        return dividendMapper.findByWN(WN);
    }

    @Override
    public List<DividendDetailsVO> findByLN(int LN) {
        return dividendMapper.findByLN(LN);
    }

    @Override
    public int sumDividendFor6monthByWN(int WN) {
        return dividendMapper.sumDividendFor6monthByWN(WN);
    }

    @Override
    public void insertDividendDetails(DividendDetailsVO dividendDetailsVO) {
        dividendMapper.insertDividendDetails(dividendDetailsVO);
    }
}
