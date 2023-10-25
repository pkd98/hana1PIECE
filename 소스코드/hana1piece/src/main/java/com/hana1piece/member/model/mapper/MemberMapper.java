package com.hana1piece.member.model.mapper;

import com.hana1piece.member.model.dto.LoginDTO;
import com.hana1piece.wallet.model.vo.StosVO;
import com.hana1piece.wallet.model.dto.WalletOpeningDTO;
import com.hana1piece.member.model.vo.OneMembersVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MemberMapper {

    List<OneMembersVO> findMemberAll();

    OneMembersVO findMemberById(String id);

    OneMembersVO findMemberByReferralCode(String referralCode);

    void increaseReferralCount(OneMembersVO oneMembersVO);

    OneMembersVO login(LoginDTO loginDTO);

    String getReferralCode();

    void insertMember(OneMembersVO oneMembersVO);

    void insertWallet(WalletOpeningDTO walletOpeningDTO);

}
