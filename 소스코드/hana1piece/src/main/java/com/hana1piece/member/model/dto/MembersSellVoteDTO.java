package com.hana1piece.member.model.dto;

import lombok.Data;

@Data
public class MembersSellVoteDTO {
    private int listingNumber;
    private String buildingName;
    private String startDate;
    private String expirationDate;
    private long dividend;
    private long amount;
    private long publicOfferingAmount;
    private long publicOfferingVolume;
    private long issuePrice;
    private long memberAmount;
    private long sellVoteTotalQuantity;
}
