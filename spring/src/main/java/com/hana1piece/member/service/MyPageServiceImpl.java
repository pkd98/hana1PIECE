package com.hana1piece.member.service;

import com.hana1piece.member.model.dto.MembersSellVoteDTO;
import com.hana1piece.member.model.dto.MembersStosInfoDTO;
import com.hana1piece.member.model.dto.MembersTotalAssetDTO;
import com.hana1piece.member.model.mapper.MypageMapper;
import com.hana1piece.trading.model.mapper.ExecutionMapper;
import com.hana1piece.trading.model.mapper.StoOrdersMapper;
import com.hana1piece.trading.model.vo.ExecutionVO;
import com.hana1piece.trading.model.vo.StoOrdersVO;
import com.hana1piece.wallet.model.vo.WalletVO;
import com.hana1piece.wallet.service.WalletService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MyPageServiceImpl implements MyPageService {

    private final MypageMapper mypageMapper;
    private final StoOrdersMapper stoOrdersMapper;
    private final ExecutionMapper executionMapper;
    private final WalletService walletService;

    @Autowired
    public MyPageServiceImpl(MypageMapper mypageMapper, StoOrdersMapper stoOrdersMapper, ExecutionMapper executionMapper, WalletService walletService) {
        this.mypageMapper = mypageMapper;
        this.stoOrdersMapper = stoOrdersMapper;
        this.executionMapper = executionMapper;
        this.walletService = walletService;
    }

    @Override
    public List<MembersStosInfoDTO> getMembersStosInfoDTOByWalletNumber(int walletNumber) {
        return mypageMapper.getMembersStosInfoDTOByWalletNumber(walletNumber);
    }

    @Override
    public List<StoOrdersVO> getMembersStoOrdersByWalletNumber(int walletNumber) {
        return stoOrdersMapper.findByWN(walletNumber);
    }


    @Override
    public MembersTotalAssetDTO getMembersTotalAsset(int walletNumber) {
        WalletVO wallet = walletService.findWalletByWN(walletNumber);
        MembersTotalAssetDTO membersTotalAssetDTO = new MembersTotalAssetDTO();
        List<MembersStosInfoDTO> membersStosInfoDTOList = getMembersStosInfoDTOByWalletNumber(walletNumber);
        for (MembersStosInfoDTO membersStosInfoDTO : membersStosInfoDTOList) {
            // 총 수익 합산
            membersTotalAssetDTO.setInvestmentReturn(membersTotalAssetDTO.getInvestmentReturn() + membersStosInfoDTO.getProfit());
            // 총 투자 금액
            membersTotalAssetDTO.setInvestmentAmount(membersTotalAssetDTO.getInvestmentAmount() + membersStosInfoDTO.getAmount() * membersStosInfoDTO.getAvgBuyPrice());
        }
        membersTotalAssetDTO.setWalletNumber(walletNumber);
        membersTotalAssetDTO.setDeposit(wallet.getBalance());
        membersTotalAssetDTO.setAsset(wallet.getBalance() + membersTotalAssetDTO.getInvestmentAmount());
        membersTotalAssetDTO.setROI(Math.round(((double) membersTotalAssetDTO.getInvestmentReturn() / (double) membersTotalAssetDTO.getInvestmentAmount()) * 10000.0) / 100.0);
        return membersTotalAssetDTO;
    }

    @Override
    public List<MembersSellVoteDTO> getMembersSellVoteDTOByWalletNumber(int walletNumber) {
        return mypageMapper.getMembersSellVoteDTOByWalletNumber(walletNumber);
    }


}