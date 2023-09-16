package com.hana1piece.estate.model.dto;

import lombok.Data;

@Data
public class ListedEstateListDTO {
    private String buildingName;
    private String image1;
    private int listingNumber;
    private String evaluation;
    private int price;
    private String state;
}
