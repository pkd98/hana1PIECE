package com.hana1piece.member.model.dto;

import lombok.Data;

@Data
public class MembersOrderPublicOfferingDTO {
    private int listingNumber;
    private int walletNumber;
    private int quantity;
    private String image1;
    private String buildingName;
    private String expirationDate;
}
