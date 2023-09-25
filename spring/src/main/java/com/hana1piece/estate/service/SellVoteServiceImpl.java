package com.hana1piece.estate.service;

import com.hana1piece.estate.model.mapper.EstateMapper;
import com.hana1piece.estate.model.mapper.SellVoteMapper;
import com.hana1piece.estate.model.vo.RealEstateSaleVO;
import com.hana1piece.estate.model.vo.SellVoteVO;
import com.hana1piece.estate.model.vo.SoldBuildingVO;
import com.hana1piece.wallet.model.mapper.DividendMapper;
import com.hana1piece.wallet.model.mapper.StosMapper;
import com.hana1piece.wallet.model.vo.DividendDetailsVO;
import com.hana1piece.wallet.model.vo.StosVO;
import com.hana1piece.wallet.model.vo.WalletTransactionVO;
import com.hana1piece.wallet.model.vo.WalletVO;
import com.hana1piece.wallet.service.WalletService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class SellVoteServiceImpl implements SellVoteService {

    private final SellVoteMapper sellVoteMapper;
    private final EstateMapper estateMapper;
    private final StosMapper stosMapper;
    private final DividendMapper dividendMapper;
    private final WalletService walletService;


    @Autowired
    public SellVoteServiceImpl(SellVoteMapper sellVoteMapper, EstateMapper estateMapper, StosMapper stosMapper, DividendMapper dividendMapper, WalletService walletService) {
        this.sellVoteMapper = sellVoteMapper;
        this.estateMapper = estateMapper;
        this.stosMapper = stosMapper;
        this.dividendMapper = dividendMapper;
        this.walletService = walletService;
    }

    @Override
    public void voting(SellVoteVO sellVoteVO) {
        System.out.println(sellVoteVO);

        // 기존 투표 있으면 update, 아니면 insert
        SellVoteVO oldSellVote = sellVoteMapper.findByLNAndWN(sellVoteVO.getListingNumber(), sellVoteVO.getWalletNumber());
        if (oldSellVote == null) {
            sellVoteMapper.insertSellVote(sellVoteVO);
        } else {
            sellVoteMapper.updateSellVote(sellVoteVO);
        }

        long publicOfferingTotalVolume = estateMapper.findPublicationInfoByLN(sellVoteVO.getListingNumber()).getVolume();
        long totalQuantity = sellVoteMapper.findTotalQuantityByLN(sellVoteVO.getListingNumber());
        long totalProsQuantity = sellVoteMapper.findTotalProsQuantityByLN(sellVoteVO.getListingNumber());

        // 투표율 100% 달성시 매각 처리
        if (totalQuantity >= publicOfferingTotalVolume) {
            // 찬성 과반수 넘을 시, 매각 처리 및 매각 배당금 지급
            if (totalProsQuantity >= totalQuantity / 2) {
                RealEstateSaleVO realEstateSaleVO = new RealEstateSaleVO();
                realEstateSaleVO.setListingNumber(sellVoteVO.getListingNumber());
                realEstateSaleVO.setState("매각");
                estateMapper.updateRealEstateSale(realEstateSaleVO);

                // 매각 배당금 지급
                SoldBuildingVO soldBuildingVO = estateMapper.findSoldBuildingByLN(sellVoteVO.getListingNumber());
                long dividend = soldBuildingVO.getDividend();
                List<StosVO> stosVOList = stosMapper.findStosByListingNumber(sellVoteVO.getListingNumber());

                for (StosVO stosVO : stosVOList) {
                    // 지갑별 총 배당금 지급액
                    System.out.println(dividend);
                    System.out.println(stosVO.getAmount());
                    long totalDividend = dividend * stosVO.getAmount();

                    // 배당금 지급 내역 기록
                    DividendDetailsVO dividendDetailsVO = new DividendDetailsVO();
                    dividendDetailsVO.setListingNumber(sellVoteVO.getListingNumber());
                    dividendDetailsVO.setWalletNumber(stosVO.getWalletNumber());
                    dividendDetailsVO.setPayout(totalDividend);
                    dividendMapper.insertDividendDetails(dividendDetailsVO);

                    // 지갑 거래내역 기록
                    WalletVO wallet = walletService.findWalletByWN(sellVoteVO.getWalletNumber());
                    wallet.setBalance(wallet.getBalance() + totalDividend);

                    WalletTransactionVO walletTransactionVO = new WalletTransactionVO();
                    walletTransactionVO.setWalletNumber(wallet.getWalletNumber());
                    walletTransactionVO.setClassification("IN");
                    walletTransactionVO.setName(stosVO.getListingNumber() + " 매각 배당");
                    walletTransactionVO.setAmount(totalDividend);
                    walletTransactionVO.setBalance(wallet.getBalance());
                    walletService.updateWalletBalance(wallet, walletTransactionVO);
                }

                // 해당 보유 토큰 소각 (삭제)
                stosMapper.deleteStosByLN(sellVoteVO.getListingNumber());
            }
        }


    }
}
