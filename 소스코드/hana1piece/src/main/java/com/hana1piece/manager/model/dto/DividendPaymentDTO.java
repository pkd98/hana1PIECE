package com.hana1piece.manager.model.dto;

import lombok.Data;

import javax.validation.constraints.Min;

@Data
public class DividendPaymentDTO {
    @Min(1)
    private int listingNumber;
    @Min(1)
    private long payout;
}
