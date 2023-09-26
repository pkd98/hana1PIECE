package com.hana1piece.estate.model.dto;

import lombok.Data;

@Data
public class SoldEstateListDTO {
    private String buildingName;
    private String image1;
    private int listingNumber;
    private String soldDate;
    private int amount;
    private long dividend;
    private String state;
    private long publicationAmount;
}