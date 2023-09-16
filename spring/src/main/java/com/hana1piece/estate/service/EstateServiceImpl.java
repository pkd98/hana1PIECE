package com.hana1piece.estate.service;

import com.hana1piece.estate.model.dto.EstateListDTO;
import com.hana1piece.estate.model.dto.ListedEstateListDTO;
import com.hana1piece.estate.model.dto.PublicOfferingListDTO;
import com.hana1piece.estate.model.mapper.EstateMapper;
import com.hana1piece.estate.model.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class EstateServiceImpl implements EstateService {

    private final EstateMapper estateMapper;

    @Autowired
    public EstateServiceImpl(EstateMapper estateMapper) {
        this.estateMapper = estateMapper;
    }

    @Override
    public List<RealEstateSaleVO> findRealEstateSaleAll() {
        return estateMapper.findRealEstateSaleAll();
    }

    @Override
    public List<RealEstateInfoVO> findRealEstateInfoAll() {
        return estateMapper.findRealEstateInfoAll();
    }

    @Override
    public List<PublicationInfoVO> findPublicationInfoAll() {
        return estateMapper.findPublicationInfoAll();
    }

    @Override
    public List<TenantInfoVO> findTenantInfoAll() {
        return estateMapper.findTenantInfoAll();
    }

    @Override
    public List<SoldBuildingVO> findSoldBuildingAll() {
        return estateMapper.findSoldBuildingAll();
    }

    @Override
    public RealEstateSaleVO findRealEstateSaleByLN(int LN) {
        return estateMapper.findRealEstateSaleByLN(LN);
    }

    @Override
    public RealEstateInfoVO findRealEstateInfoByLN(int LN) {
        return estateMapper.findRealEstateInfoByLN(LN);
    }

    @Override
    public PublicationInfoVO findPublicationInfoByLN(int LN) {
        return estateMapper.findPublicationInfoByLN(LN);
    }

    @Override
    public TenantInfoVO findTenantInfoByLN(int LN) {
        return estateMapper.findTenantInfoByLN(LN);
    }

    @Override
    public SoldBuildingVO findSoldBuildingByLN(int LN) {
        return estateMapper.findSoldBuildingByLN(LN);
    }

    @Override
    public void updateRealEstateSale(RealEstateSaleVO realEstateSaleVO) {
        estateMapper.updateRealEstateSale(realEstateSaleVO);
    }

    @Override
    public List<PublicOfferingListDTO> findPublicOfferingListDTO() {
        return estateMapper.findPublicOfferingListDTO();
    }

    @Override
    public List<ListedEstateListDTO> findListedEstateListDTO() {
        return estateMapper.findListedEstateListDTO();
    }

    @Override
    public List<EstateListDTO> findEstateListDTO() {
        return estateMapper.findEstateListDTO();
    }
}