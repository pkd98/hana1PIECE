package com.hana1piece.estate.model.mapper;

import com.hana1piece.estate.model.vo.PublicOfferingVO;
import com.hana1piece.member.model.dto.MembersOrderPublicOfferingDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PublicOfferingMapper {
    List<PublicOfferingVO> findAll();

    PublicOfferingVO findByWalletNumber(int walletNumber);

    void insertPublicOffering(PublicOfferingVO publicOfferingVO);

    List<MembersOrderPublicOfferingDTO> findMembersOrderPublicationOfferingByWalletNumber(int walletNumber);
}
