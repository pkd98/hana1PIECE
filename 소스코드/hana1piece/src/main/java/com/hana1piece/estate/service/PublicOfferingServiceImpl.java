package com.hana1piece.estate.service;

import com.hana1piece.estate.model.dto.OrderPublicOfferingDTO;
import com.hana1piece.estate.model.dto.PublicOfferingProgressDTO;
import com.hana1piece.estate.model.mapper.EstateMapper;
import com.hana1piece.estate.model.mapper.PublicOfferingMapper;
import com.hana1piece.estate.model.vo.PublicOfferingVO;
import com.hana1piece.logger.service.LoggerService;
import com.hana1piece.member.model.dto.MembersOrderPublicOfferingDTO;
import com.hana1piece.wallet.model.vo.WalletTransactionVO;
import com.hana1piece.wallet.model.vo.WalletVO;
import com.hana1piece.wallet.service.WalletService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class PublicOfferingServiceImpl implements PublicOfferingService {

    private final EstateMapper estateMapper;
    private final WalletService walletService;
    private final PublicOfferingMapper publicOfferingMapper;
    private final LoggerService loggerService;

    @Autowired
    public PublicOfferingServiceImpl(EstateMapper estateMapper, WalletService walletService, PublicOfferingMapper publicOfferingMapper, LoggerService loggerService) {
        this.estateMapper = estateMapper;
        this.walletService = walletService;
        this.publicOfferingMapper = publicOfferingMapper;
        this.loggerService = loggerService;
    }

    /**
     * 청약 주문
     *
     * @param orderPublicOfferingDTO
     * @throws Exception
     */
    @Override
    public void order(OrderPublicOfferingDTO orderPublicOfferingDTO) throws Exception {
        try {
            int price = 5000;
            long amount = (long) orderPublicOfferingDTO.getQuantity() * (long) price;
            WalletVO wallet = walletService.findWalletByWN(orderPublicOfferingDTO.getWalletNumber());

            // 지갑 비밀번호 확인
            if (!wallet.getPassword().equals(orderPublicOfferingDTO.getWalletPassword())) {
                throw new Exception();
            }

            // 주문 금액, 지갑 잔액 유효성
            if (wallet.getBalance() < (long) orderPublicOfferingDTO.getQuantity() * (long) price) {
                throw new Exception();
            }

            // 지갑 잔액 차감
            WalletTransactionVO walletTransactionVO = new WalletTransactionVO();
            walletTransactionVO.setWalletNumber(wallet.getWalletNumber());
            walletTransactionVO.setClassification("OUT");
            walletTransactionVO.setName("청약 주문");
            walletTransactionVO.setAmount(-amount);
            walletTransactionVO.setBalance(wallet.getBalance() - amount);
            walletService.updateWalletBalance(wallet, walletTransactionVO);

            // 주문 정상 처리
            PublicOfferingVO publicOfferingVO = new PublicOfferingVO();
            publicOfferingVO.setListingNumber(orderPublicOfferingDTO.getListingNumber());
            publicOfferingVO.setWalletNumber(orderPublicOfferingDTO.getWalletNumber());
            publicOfferingVO.setQuantity(orderPublicOfferingDTO.getQuantity());
            publicOfferingMapper.insertPublicOffering(publicOfferingVO);
        } catch (Exception e) {
            e.printStackTrace();
            loggerService.logException("ERR", "orderPublicOffering", e.getMessage(), "");
            throw e;
        }

    }

    /**
     * 사용자 마이페이지 청약 내역
     *
     * @param walletNumber
     * @return
     */
    @Override
    public List<MembersOrderPublicOfferingDTO> findMembersOrderPublicationOfferingByWalletNumber(int walletNumber) {
        return publicOfferingMapper.findMembersOrderPublicationOfferingByWalletNumber(walletNumber);
    }

    @Override
    public List<PublicOfferingVO> findAll() {
        return publicOfferingMapper.findAll();
    }

    @Override
    public List<PublicOfferingVO> findByWalletNumber(int walletNumber) {
        return publicOfferingMapper.findByWalletNumber(walletNumber);
    }

    @Override
    public List<PublicOfferingVO> findByListingNumber(int listingNumber) {
        return publicOfferingMapper.findByListingNumber(listingNumber);
    }

    @Override
    public PublicOfferingProgressDTO findPublicOfferingProgressByListingNumber(int LN) {
        return publicOfferingMapper.findPublicOfferingProgressByListingNumber(LN);
    }
}
