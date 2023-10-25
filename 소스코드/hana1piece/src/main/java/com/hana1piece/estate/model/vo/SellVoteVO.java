package com.hana1piece.estate.model.vo;

import lombok.Data;

@Data
public class SellVoteVO {
    private int id;
    private int listingNumber;
    private int walletNumber;
    private String prosCons;
    private long quantity;
    private String sellVoteDate;
}
