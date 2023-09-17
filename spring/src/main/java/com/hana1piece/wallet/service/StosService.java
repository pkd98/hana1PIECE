package com.hana1piece.wallet.service;

import com.hana1piece.wallet.model.vo.StosVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StosService {
    List<StosVO> findStosByWalletNumber(int walletNumber);
    List<StosVO> findStosByListingNumber(int listingNumber);
    StosVO findStosByWalletNumberAndListingNumber(@Param("walletNumber") int walletNumber, @Param("listingNumber") int listingNumber);
    void insertStos(StosVO stos);

}
