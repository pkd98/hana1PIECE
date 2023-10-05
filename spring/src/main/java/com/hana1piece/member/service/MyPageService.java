package com.hana1piece.member.service;

import com.hana1piece.member.model.dto.MembersSellVoteDTO;
import com.hana1piece.member.model.dto.MembersStosInfoDTO;
import com.hana1piece.member.model.dto.MembersTotalAssetDTO;
import com.hana1piece.trading.model.vo.ExecutionVO;
import com.hana1piece.trading.model.vo.StoOrdersVO;

import java.util.List;

public interface MyPageService {

    List<MembersStosInfoDTO> getMembersStosInfoDTOByWalletNumber(int walletNumber);

    List<StoOrdersVO> getMembersStoOrdersByWalletNumber(int walletNumber);

    MembersTotalAssetDTO getMembersTotalAsset(int walletNumber);

    List<MembersSellVoteDTO> getMembersSellVoteDTOByWalletNumber(int walletNumber);

}
