package com.hana1piece.estate.model.dto;

import lombok.Data;

@Data
public class RequestSellVoteDTO {
    private int listingNumber;
    private String prosCons; // P or C
    private long quantity;
}
