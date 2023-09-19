package com.hana1piece.estate.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hana1piece.estate.model.dto.*;
import com.hana1piece.estate.model.mapper.EstateMapper;
import com.hana1piece.estate.model.vo.*;
import com.hana1piece.wallet.model.vo.BankTransactionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@Service
@Transactional
public class EstateServiceImpl implements EstateService {
    @Value("${price.evaluation.server.url}")
    private String ServerUrl;
    private final RestTemplate restTemplate;
    private final EstateMapper estateMapper;
    private final ObjectMapper objectMapper;


    @Autowired
    public EstateServiceImpl(RestTemplate restTemplate, EstateMapper estateMapper, ObjectMapper objectMapper) {
        this.restTemplate = restTemplate;
        this.estateMapper = estateMapper;
        this.objectMapper = objectMapper;
    }

    @Override
    public List<RealEstateSaleVO> findRealEstateSaleAll() {
        return estateMapper.findRealEstateSaleAll();
    }

    @Override
    public List<RealEstateInfoVO> findRealEstateInfoAll() {
        return estateMapper.findRealEstateInfoAll();
    }

    @Override
    public List<PublicationInfoVO> findPublicationInfoAll() {
        return estateMapper.findPublicationInfoAll();
    }

    @Override
    public List<TenantInfoVO> findTenantInfoAll() {
        return estateMapper.findTenantInfoAll();
    }

    @Override
    public List<SoldBuildingVO> findSoldBuildingAll() {
        return estateMapper.findSoldBuildingAll();
    }

    @Override
    public RealEstateSaleVO findRealEstateSaleByLN(int LN) {
        return estateMapper.findRealEstateSaleByLN(LN);
    }

    @Override
    public RealEstateInfoVO findRealEstateInfoByLN(int LN) {
        return estateMapper.findRealEstateInfoByLN(LN);
    }

    @Override
    public PublicationInfoVO findPublicationInfoByLN(int LN) {
        return estateMapper.findPublicationInfoByLN(LN);
    }

    @Override
    public TenantInfoVO findTenantInfoByLN(int LN) {
        return estateMapper.findTenantInfoByLN(LN);
    }

    @Override
    public SoldBuildingVO findSoldBuildingByLN(int LN) {
        return estateMapper.findSoldBuildingByLN(LN);
    }

    @Override
    public void updateRealEstateSale(RealEstateSaleVO realEstateSaleVO) {
        estateMapper.updateRealEstateSale(realEstateSaleVO);
    }

    @Override
    public List<PublicOfferingListDTO> findPublicOfferingListDTO() {
        return estateMapper.findPublicOfferingListDTO();
    }

    @Override
    public List<ListedEstateListDTO> findListedEstateListDTO() {
        return estateMapper.findListedEstateListDTO();
    }

    @Override
    public List<EstateListDTO> findEstateListDTO() {
        return estateMapper.findEstateListDTO();
    }

    @Override
    public boolean evaluateEstate(RealEstateSaleVO realEstateSaleVO, RequestEstateEvaluationDTO requestEstateEvaluationDTO) {
        String url = ServerUrl + "building-evaluation";

        // HTTP 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // HTTP 요청 엔티티 생성
        HttpEntity<RequestEstateEvaluationDTO> requestEntity = new HttpEntity<>(requestEstateEvaluationDTO, headers);

        // HTTP PUT 요청 보내기
        ResponseEntity<String> responseEntity = restTemplate.exchange(
                url,
                HttpMethod.POST,
                requestEntity,
                String.class
        );

        // 응답 확인
        if (responseEntity.getStatusCode() == HttpStatus.OK) {

            String responseBody = responseEntity.getBody();

            // JSON 문자열을 ObjectMapper를 사용하여 JsonNode로 읽음
            try {
                JsonNode root = objectMapper.readTree(responseBody);
                JsonNode dataNode = root.get("response_data");

                // JsonNode를 List<BankTransactionVO>로 매핑
                ResponseEstateEvaluationDTO responseEstateEvaluationDTO = objectMapper.readValue(
                        dataNode.toString(),
                        new TypeReference<ResponseEstateEvaluationDTO>() {}
                );

                realEstateSaleVO.setEvaluation(responseEstateEvaluationDTO.getEvaluation());
                realEstateSaleVO.setReasonablePrice(responseEstateEvaluationDTO.getReasonablePrice());
                estateMapper.updateRealEstateSale(realEstateSaleVO);

            } catch (Exception e) {
                e.printStackTrace();
            }

            System.out.println("응답 본문: " + responseBody);
            return true;
        } else {
            System.out.println("요청 실패: " + responseEntity.getStatusCode());
            return false;
        }



    }
}