package com.hana1piece.wallet.service;

import com.hana1piece.wallet.model.mapper.StosMapper;
import com.hana1piece.wallet.model.vo.StosVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class StosServiceImpl implements StosService {

    private final StosMapper stosMapper;

    @Autowired
    public StosServiceImpl(StosMapper stosMapper) {
        this.stosMapper = stosMapper;
    }


    @Override
    public List<StosVO> findStosByWalletNumber(int walletNumber) {
        return stosMapper.findStosByWalletNumber(walletNumber);
    }

    @Override
    public List<StosVO> findStosByListingNumber(int listingNumber) {
        return stosMapper.findStosByListingNumber(listingNumber);
    }

    @Override
    public StosVO findStosByWalletNumberAndListingNumber(int walletNumber, int listingNumber) {
        return stosMapper.findStosByWalletNumberAndListingNumber(walletNumber, listingNumber);
    }

    @Override
    public void insertStos(StosVO stos) {
        stosMapper.insertStos(stos);
    }

    @Override
    public void updateAmount(StosVO stos) {
        stosMapper.updateAmount(stos);
    }

}