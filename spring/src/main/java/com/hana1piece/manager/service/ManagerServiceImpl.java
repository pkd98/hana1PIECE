package com.hana1piece.manager.service;

import com.hana1piece.estate.model.mapper.EstateMapper;
import com.hana1piece.estate.model.mapper.PublicOfferingMapper;
import com.hana1piece.estate.model.vo.*;
import com.hana1piece.logger.service.LoggerService;
import com.hana1piece.manager.model.dto.ManagerLoginDTO;
import com.hana1piece.manager.model.dto.PublicOfferingRegistrationDTO;
import com.hana1piece.manager.model.mapper.ManagerMapper;
import com.hana1piece.manager.model.vo.ManagerVO;
import com.hana1piece.member.model.mapper.MemberMapper;
import com.hana1piece.wallet.model.mapper.StosMapper;
import com.hana1piece.wallet.model.vo.StosVO;
import com.hana1piece.member.service.MemberService;
import com.hana1piece.trading.model.mapper.OrderBookMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
@Transactional
public class ManagerServiceImpl implements ManagerService {

    private final ManagerMapper managerMapper;
    private final EstateMapper estateMapper;
    private final PublicOfferingMapper publicOfferingMapper;
    private final MemberMapper memberMapper;
    private final StosMapper stosMapper;
    private final OrderBookMapper orderBookMapper;
    private final LoggerService loggerService;

    @Value("${imgFilePath}")
    private String imgFilePath;

    @Autowired
    public ManagerServiceImpl(ManagerMapper managerMapper, EstateMapper estateMapper, PublicOfferingMapper publicOfferingMapper, MemberService memberService, MemberMapper memberMapper, StosMapper stosMapper, OrderBookMapper orderBookMapper, LoggerService loggerService) {
        this.managerMapper = managerMapper;
        this.estateMapper = estateMapper;
        this.publicOfferingMapper = publicOfferingMapper;
        this.memberMapper = memberMapper;
        this.stosMapper = stosMapper;
        this.orderBookMapper = orderBookMapper;
        this.loggerService = loggerService;
    }

    @Override
    public boolean login(ManagerLoginDTO loginDTO, HttpSession session) {
        try {
            ManagerVO manager = managerMapper.login(loginDTO);
            System.out.println(manager.toString());
            // 로그인 실패
            if (manager == null) {
                return false;
            } else { // 로그인 성공
                session.setAttribute("manager", manager);
                return true;
            }
        } catch (Exception e) {
            // 예기치 못한 에러
            loggerService.logException("ERR", "manager-login", e.getMessage(), "");
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * [공모/청약 등록]
     * 1. 이미지 저장
     * 2. 매물 등록
     * 3. 매물 상세 정보 등록
     * 4. 발행 정보 등록
     * 5. 임차인 정보 등록
     *
     * @param publicOfferingRegistrationDTO
     * @throws IOException
     */
    @Override
    public void publicOfferingRegistration(PublicOfferingRegistrationDTO publicOfferingRegistrationDTO) throws IOException {
        try {
            // 매물 등록
            registerEstateSale();

            // 등록된 매물 번호 가져오기
            int listingNumber = getRecentListingNumber();

            // 이미지 파일 저장
            convertMultiPartToFile(publicOfferingRegistrationDTO.getImage1(), listingNumber);
            convertMultiPartToFile(publicOfferingRegistrationDTO.getImage2(), listingNumber);
            convertMultiPartToFile(publicOfferingRegistrationDTO.getImage3(), listingNumber);

            // 매물 상세 정보 등록
            RealEstateInfoVO realEstateInfoVO = new RealEstateInfoVO();
            realEstateInfoVO.setListingNumber(listingNumber);
            realEstateInfoVO.setBuildingName(publicOfferingRegistrationDTO.getBuildingName());
            realEstateInfoVO.setAddress(publicOfferingRegistrationDTO.getAddress());
            realEstateInfoVO.setSupplyArea(publicOfferingRegistrationDTO.getSupplyArea());
            realEstateInfoVO.setFloors(publicOfferingRegistrationDTO.getFloors());
            realEstateInfoVO.setUsage(publicOfferingRegistrationDTO.getUsage());
            realEstateInfoVO.setLandArea(publicOfferingRegistrationDTO.getLandArea());
            realEstateInfoVO.setFloorArea(publicOfferingRegistrationDTO.getFloorArea());
            realEstateInfoVO.setCoverageRatio(publicOfferingRegistrationDTO.getCoverageRatio());
            realEstateInfoVO.setFloorAreaRatio(publicOfferingRegistrationDTO.getFloorAreaRatio());
            realEstateInfoVO.setCompletionDate(publicOfferingRegistrationDTO.getCompletionDate());
            realEstateInfoVO.setImage1(publicOfferingRegistrationDTO.getImage1().getOriginalFilename());
            realEstateInfoVO.setImage2(publicOfferingRegistrationDTO.getImage2().getOriginalFilename());
            realEstateInfoVO.setImage3(publicOfferingRegistrationDTO.getImage3().getOriginalFilename());
            realEstateInfoVO.setLatitude(publicOfferingRegistrationDTO.getLatitude());
            realEstateInfoVO.setLongitude(publicOfferingRegistrationDTO.getLongitude());
            registerEstateInfo(realEstateInfoVO);

            // 발행 정보 등록
            PublicationInfoVO publicationInfoVO = new PublicationInfoVO();
            publicationInfoVO.setListingNumber(listingNumber);
            publicationInfoVO.setSubject(publicOfferingRegistrationDTO.getBuildingName());
            publicationInfoVO.setType("수익증권");
            publicationInfoVO.setPublisher(publicOfferingRegistrationDTO.getPublisher());
            publicationInfoVO.setVolume(publicOfferingRegistrationDTO.getVolume());
            publicationInfoVO.setIssuePrice(publicOfferingRegistrationDTO.getIssuePrice());
            publicationInfoVO.setTotalAmount(publicOfferingRegistrationDTO.getTotalAmount());
            publicationInfoVO.setStartDate(publicOfferingRegistrationDTO.getStartDate());
            publicationInfoVO.setExpirationDate(publicOfferingRegistrationDTO.getExpirationDate());
            publicationInfoVO.setFirstDividendDate(publicOfferingRegistrationDTO.getFirstDividendDate());
            publicationInfoVO.setDividendCycle(publicOfferingRegistrationDTO.getDividendCycle());
            publicationInfoVO.setDividend(publicOfferingRegistrationDTO.getDividend());
            registerPublicationInfo(publicationInfoVO);

            // 임차인 정보 등록
            TenantInfoVO tenantInfoVO = new TenantInfoVO();
            tenantInfoVO.setListingNumber(listingNumber);
            tenantInfoVO.setLessee(publicOfferingRegistrationDTO.getLessee());
            tenantInfoVO.setSector(publicOfferingRegistrationDTO.getSector());
            tenantInfoVO.setContractDate(publicOfferingRegistrationDTO.getContractDate());
            tenantInfoVO.setExpirationDate(publicOfferingRegistrationDTO.getLesseeExpirationDate());
            registerTenantInfo(tenantInfoVO);

            // 건물 소개글 업데이트
            RealEstateSaleVO realEstateSaleVO = new RealEstateSaleVO();
            realEstateSaleVO.setListingNumber(listingNumber);
            realEstateSaleVO.setIntroduction(publicOfferingRegistrationDTO.getIntroduction());
            estateMapper.updateRealEstateSale(realEstateSaleVO);

        } catch (Exception e) {
            // 예기치 못한 에러
            loggerService.logException("ERR", "publicOfferingRegistration", e.getMessage(), "");
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * 매물 상장
     * 1. 매물 상태 청약 -> 거래 변경
     * 2. 청약 신청 회원 보유 토큰 : 조각 지급
     * 3. 호가창 셋팅
     */
    @Override
    public void estateListing(int listingNumber) {
        try {
            // 1. 매물 상태 변경
            RealEstateSaleVO realEstateSaleVO = new RealEstateSaleVO();
            realEstateSaleVO.setListingNumber(listingNumber);
            realEstateSaleVO.setState("거래");
            estateMapper.updateRealEstateSale(realEstateSaleVO);

            // 2. 토큰 지급
            List<PublicOfferingVO> publicOfferingVOList = publicOfferingMapper.findByListingNumber(listingNumber);
            for(PublicOfferingVO publicOfferingVO : publicOfferingVOList) {
                StosVO stos = new StosVO();
                stos.setListingNumber(publicOfferingVO.getListingNumber());
                stos.setWalletNumber(publicOfferingVO.getWalletNumber());
                stos.setAmount(publicOfferingVO.getQuantity());
                stosMapper.insertStos(stos);
            }

            // 3. 호가창 셋팅
            orderBookMapper.init(listingNumber);

        } catch (Exception e) {
            loggerService.logException("ERR", "estateListing", e.getMessage(), "");
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void registerEstateSale() {
        estateMapper.insertRealEstateSale();
    }

    @Override
    public int getRecentListingNumber() {
        return estateMapper.getRecentListingNumber();
    }

    @Override
    public void registerEstateInfo(RealEstateInfoVO realEstateInfoVO) {
        estateMapper.insertRealEstateInfo(realEstateInfoVO);
    }

    @Override
    public void registerPublicationInfo(PublicationInfoVO publicationInfoVO) {
        estateMapper.insertPublicationInfo(publicationInfoVO);
    }

    @Override
    public void registerTenantInfo(TenantInfoVO tenantInfoVO) {
        estateMapper.insertTenantInfo(tenantInfoVO);
    }

    /**
     * MultipartFile 타입에서 File 타입으로 변환
     */
    public File convertMultiPartToFile(MultipartFile multipartFile, int listingNumber) throws IOException {
        // 디렉터리 생성
        File directory = new File(imgFilePath + listingNumber);
        if (!directory.exists()) {
            directory.mkdirs(); // 디렉터리가 존재하지 않으면 생성
        }

        File file = new File(directory, multipartFile.getOriginalFilename()); // 파일 저장
        multipartFile.transferTo(file); // MultipartFile의 내용을 파일로 복사
        return file;
    }

}
