package com.hana1piece.estate.service;

import com.hana1piece.estate.model.dto.EstateListDTO;
import com.hana1piece.estate.model.dto.PublicOfferingListDTO;
import com.hana1piece.estate.model.vo.*;

import java.util.List;

public interface EstateService {
    List<RealEstateSaleVO> findRealEstateSaleAll();

    List<RealEstateInfoVO> findRealEstateInfoAll();

    List<PublicationInfoVO> findPublicationInfoAll();

    List<TenantInfoVO> findTenantInfoAll();

    List<SoldBuildingVO> findSoldBuildingAll();

    RealEstateSaleVO findRealEstateSaleByLN(int LN);

    RealEstateInfoVO findRealEstateInfoByLN(int LN);

    PublicationInfoVO findPublicationInfoByLN(int LN);

    TenantInfoVO findTenantInfoByLN(int LN);

    SoldBuildingVO findSoldBuildingByLN(int LN);

    void updateRealEstateSale(RealEstateSaleVO realEstateSaleVO);

    List<PublicOfferingListDTO> findPublicOfferingListDTO();

    List<EstateListDTO> findEstateListDTO();
}
