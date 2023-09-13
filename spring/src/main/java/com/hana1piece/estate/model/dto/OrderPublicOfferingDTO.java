package com.hana1piece.estate.model.dto;

import lombok.Data;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;

@Data
public class OrderPublicOfferingDTO {
    @Min(1)
    private int listingNumber;
    @Min(1)
    private int walletNumber;
    @Min(1)
    private int quantity;
    @NotEmpty
    private String walletPassword;
}
