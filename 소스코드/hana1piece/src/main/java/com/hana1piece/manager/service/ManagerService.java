package com.hana1piece.manager.service;

import com.hana1piece.estate.model.vo.*;
import com.hana1piece.manager.model.dto.DividendPaymentDTO;
import com.hana1piece.manager.model.dto.ManagerLoginDTO;
import com.hana1piece.manager.model.dto.PublicOfferingRegistrationDTO;
import com.hana1piece.manager.model.dto.TransactionStatusDTO;
import com.hana1piece.trading.model.vo.ExecutionVO;
import com.hana1piece.trading.model.vo.StoOrdersVO;
import com.hana1piece.wallet.model.vo.DividendDetailsVO;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public interface ManagerService {
    /**
     * 로그인
     */
    boolean login(ManagerLoginDTO loginDTO, HttpSession session);

    /**
     * 공모 청약 - 매물 등록
     */
    void publicOfferingRegistration(PublicOfferingRegistrationDTO publicOfferingRegistrationDTO) throws IOException;

    /**
     * 매물 상장
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


    /**
     * 배당금 지급
     */
    void dividendPayment(DividendPaymentDTO dividendPaymentDTO);

    void dividendPaymentUsingProcedure(DividendPaymentDTO dividendPaymentDTO);


    /**
     * 매각 매물 등록 (투표)
     */
    void registerSaleVote(SoldBuildingVO soldBuildingVO);

    /**
     * 거래 현황
     */
    TransactionStatusDTO getTransactionStatus();

    /**
     * 주문 내역 (페이지 네이션)
     */
    public List<StoOrdersVO> getOrdersByPage(int pageNum);

    /**
     * 체결 내역 (페이지 네이션)
     */
    public List<ExecutionVO> getExecutionsByPage(int pageNum);

    /**
     * 배당금 지급 내역 (페이지 네이션)
     */
    public List<DividendDetailsVO> getDividendDetailsByPage(int pageNum);

    /**
     * 총 테이블 수
     */
    int getTotalOrderCount();

    int getTotalExecutionCount();

    int getTotalPaymentCount();

}
