package com.hana1piece.estate.model.vo;

import lombok.Data;

@Data
public class RealEstateInfoVO {
    private int listingNumber;
    private String buildingName;
    private String address;
    private int supplyArea;
    private int floors;
    private String usage;
    private String landArea;
    private String floorArea;
    private double coverageRatio;
    private double floorAreaRatio;
    private String completionDate;
    private String image1;
    private String image2;
    private String image3;
    private double latitude;
    private double longitude;
}
