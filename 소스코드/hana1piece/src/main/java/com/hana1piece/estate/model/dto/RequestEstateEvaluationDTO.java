package com.hana1piece.estate.model.dto;

import lombok.Data;

@Data
public class RequestEstateEvaluationDTO {
    private String buildingName;
    private double latitude;
    private double longitude;
    private double size;
    private long price;
    private long volume;
}
