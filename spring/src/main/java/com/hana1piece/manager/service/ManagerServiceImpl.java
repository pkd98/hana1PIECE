package com.hana1piece.manager.service;

import com.hana1piece.estate.model.mapper.EstateMapper;
import com.hana1piece.estate.model.vo.PublicationInfoVO;
import com.hana1piece.estate.model.vo.RealEstateInfoVO;
import com.hana1piece.estate.model.vo.RealEstateSaleVO;
import com.hana1piece.estate.model.vo.TenantInfoVO;
import com.hana1piece.logger.service.LoggerService;
import com.hana1piece.manager.model.dto.ManagerLoginDTO;
import com.hana1piece.manager.model.dto.PublicOfferingRegistrationDTO;
import com.hana1piece.manager.model.mapper.ManagerMapper;
import com.hana1piece.manager.model.vo.ManagerVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;

@Service
@Transactional
public class ManagerServiceImpl implements ManagerService {

    private final ManagerMapper managerMapper;
    private final EstateMapper estateMapper;
    private final LoggerService loggerService;

    @Value("${imgFilePath}")
    private String imgFilePath;

    @Autowired
    public ManagerServiceImpl(ManagerMapper managerMapper, EstateMapper estateMapper, LoggerService loggerService) {
        this.managerMapper = managerMapper;
        this.estateMapper = estateMapper;
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

    @Override
    public void publicOfferingRegistration(PublicOfferingRegistrationDTO publicOfferingRegistrationDTO) throws IOException {
        try {
            // 이미지 파일 저장
            convertMultiPartToFile(publicOfferingRegistrationDTO.getImage1());
            convertMultiPartToFile(publicOfferingRegistrationDTO.getImage2());
            convertMultiPartToFile(publicOfferingRegistrationDTO.getImage3());

            // 매물 등록
            estateMapper.insertRealEstateSale();

            // 등록된 매물 번호 가져오기
            int listingNumber = getRecentListingNumber();

            // 매물 상세 정보 등록
            RealEstateInfoVO realEstateInfoVO = new RealEstateInfoVO();
            realEstateInfoVO.setListingNumber(listingNumber);
            realEstateInfoVO.setBuildingName(publicOfferingRegistrationDTO.getBuildingName());
            realEstateInfoVO.setAddress(publicOfferingRegistrationDTO.getAddress());
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
            estateMapper.insertRealEstateInfo(realEstateInfoVO);

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
            estateMapper.insertPublicationInfo(publicationInfoVO);

            // 임차인 정보 등록
            TenantInfoVO tenantInfoVO = new TenantInfoVO();
            tenantInfoVO.setListingNumber(listingNumber);
            tenantInfoVO.setLessee(publicOfferingRegistrationDTO.getLessee());
            tenantInfoVO.setSector(publicOfferingRegistrationDTO.getSector());
            tenantInfoVO.setContractDate(publicOfferingRegistrationDTO.getContractDate());
            tenantInfoVO.setExpirationDate(publicOfferingRegistrationDTO.getLesseeExpirationDate());
            estateMapper.insertTenantInfo(tenantInfoVO);

        } catch (Exception e) {
            // 예기치 못한 에러
            loggerService.logException("ERR", "publicOfferingRegistration", e.getMessage(), "");
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void registerEstateSale() {

    }

    @Override
    public int getRecentListingNumber() {
        return estateMapper.getRecentListingNumber();
    }

    @Override
    public void registerEstateInfo(RealEstateInfoVO realEstateInfoVO) {

    }

    @Override
    public void registerPublicationInfo(PublicationInfoVO publicationInfoVO) {

    }

    @Override
    public void registerTenantInfo(TenantInfoVO tenantInfoVO) {

    }

    /**
     * MultipartFile 타입에서 File 타입으로 변환
     */
    public File convertMultiPartToFile(MultipartFile multipartFile) throws IOException {
        File file = new File(imgFilePath + multipartFile.getOriginalFilename()); // 파일 저장
        multipartFile.transferTo(file); // MultipartFile의 내용을 파일로 복사
        return file;
    }

}
