package com.hana1piece.wallet.model.mapper;

import com.hana1piece.wallet.model.vo.StosVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface StosMapper {
    List<StosVO> findStosByWalletNumber(int walletNumber);
    List<StosVO> findStosByListingNumber(int listingNumber);
    StosVO findStosByWalletNumberAndListingNumber(@Param("walletNumber") int walletNumber, @Param("listingNumber") int listingNumber);
    void insertStos(StosVO stos);
    void updateAmount(StosVO stosVO);
    void deleteStosByLN(int LN);
}
