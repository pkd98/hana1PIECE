package com.hana1piece.estate.model.mapper;

import com.hana1piece.estate.model.dto.EstateListDTO;
import com.hana1piece.estate.model.dto.ListedEstateListDTO;
import com.hana1piece.estate.model.dto.PublicOfferingListDTO;
import com.hana1piece.estate.model.vo.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EstateMapper {
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

    void insertRealEstateSale();

    int getRecentListingNumber();

    void updateRealEstateSale(RealEstateSaleVO realEstateSaleVO);

    void insertRealEstateInfo(RealEstateInfoVO realEstateInfoVO);

    void insertPublicationInfo(PublicationInfoVO publicationInfoVO);

    void insertTenantInfo(TenantInfoVO tenantInfoVO);

    void insertSoldBuilding(SoldBuildingVO soldBuildingVO);

    List<PublicOfferingListDTO> findPublicOfferingListDTO();

    List<ListedEstateListDTO> findListedEstateListDTO();

    List<EstateListDTO> findEstateListDTO();

}
