package com.hana1piece.member.service;

import com.hana1piece.member.model.dto.MembersStosInfoDTO;

import java.util.List;

public interface MyPageService {

    List<MembersStosInfoDTO> getMembersStosInfoDTOByWalletNumber(int walletNumber);

}
