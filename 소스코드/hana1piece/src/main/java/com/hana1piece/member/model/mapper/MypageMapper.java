package com.hana1piece.member.model.mapper;

import com.hana1piece.member.model.dto.MembersSellVoteDTO;
import com.hana1piece.member.model.dto.MembersStosInfoDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MypageMapper {
    List<MembersStosInfoDTO> getMembersStosInfoDTOByWalletNumber(int walletNumber);

    List<MembersSellVoteDTO> getMembersSellVoteDTOByWalletNumber(int walletNumber);
}
