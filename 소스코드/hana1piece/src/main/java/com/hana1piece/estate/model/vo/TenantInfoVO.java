package com.hana1piece.estate.model.vo;

import lombok.Data;

@Data
public class TenantInfoVO {
    private int listingNumber;
    private String lessee;
    private String sector;
    private String contractDate;
    private String expirationDate;
}
