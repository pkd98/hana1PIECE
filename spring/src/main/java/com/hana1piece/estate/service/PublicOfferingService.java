package com.hana1piece.estate.service;

import com.hana1piece.estate.model.dto.OrderPublicOfferingDTO;
import com.hana1piece.member.model.dto.MembersOrderPublicOfferingDTO;

import java.util.List;

public interface PublicOfferingService {
    /**
     *  사용자 공모 청약 신청 처리
     */
    void order(OrderPublicOfferingDTO orderPublicOfferingDTO) throws Exception;

    /**
     *  사용자 마이페이지 청약 내역
     */
    List<MembersOrderPublicOfferingDTO> findMembersOrderPublicationOfferingByWalletNumber(int walletNumber);

}
