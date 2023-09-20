package com.hana1piece.manager.model.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class PublicOfferingRegistrationDTO {
    private String buildingName;
    private String address;
    private int supplyArea;
    private int floors;
    private String usage;
    private String landArea;
    private String floorArea;
    private double coverageRatio;
    private double floorAreaRatio;
    private double latitude;
    private double longitude;
    private String completionDate;
    private MultipartFile image1;
    private MultipartFile image2;
    private MultipartFile image3;
    private String publisher;
    private long volume;
    private long issuePrice;
    private long totalAmount;
    private String startDate;
    private String expirationDate;
    private String firstDividendDate;
    private String dividendCycle;
    private int dividend;
    private String lessee;
    private String sector;
    private String contractDate;
    private String lesseeExpirationDate;
    private String introduction;
}
