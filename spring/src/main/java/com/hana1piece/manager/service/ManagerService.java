package com.hana1piece.manager.service;

import com.hana1piece.estate.model.vo.*;
import com.hana1piece.manager.model.dto.ManagerLoginDTO;
import com.hana1piece.manager.model.dto.PublicOfferingRegistrationDTO;

import javax.servlet.http.HttpSession;
import java.io.IOException;

public interface ManagerService {
    /**
     *  로그인
     */
    boolean login(ManagerLoginDTO loginDTO, HttpSession session);

    /**
     * 공모 청약 - 매물 등록
     */
    void publicOfferingRegistration(PublicOfferingRegistrationDTO publicOfferingRegistrationDTO) throws IOException;

    /**
     *  매물 상장
     */
    void estateListing(int listingNumber);

    // 매물 등록
    void registerEstateSale();

    int getRecentListingNumber();

    // 매물 상세 정보 등록
    void registerEstateInfo(RealEstateInfoVO realEstateInfoVO);

    // 발행 정보 등록
    void registerPublicationInfo(PublicationInfoVO publicationInfoVO);

    // 임차인 정보 등록
    void registerTenantInfo(TenantInfoVO tenantInfoVO);

    // 매각 매물 등록 (투표)
    void registerSaleVote(SoldBuildingVO soldBuildingVO);
}
