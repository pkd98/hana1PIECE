package com.hana1piece.member.service;

import com.hana1piece.member.model.dto.MembersStosInfoDTO;
import com.hana1piece.member.model.mapper.MypageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MyPageServiceImpl implements MyPageService {

    private final MypageMapper mypageMapper;

    @Autowired
    public MyPageServiceImpl(MypageMapper mypageMapper) {
        this.mypageMapper = mypageMapper;
    }

    @Override
    public List<MembersStosInfoDTO> getMembersStosInfoDTOByWalletNumber(int walletNumber) {
        return mypageMapper.getMembersStosInfoDTOByWalletNumber(walletNumber);
    }
}
