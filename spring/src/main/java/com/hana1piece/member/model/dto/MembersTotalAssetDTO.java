package com.hana1piece.member.model.dto;

import lombok.Data;

@Data
public class MembersTotalAssetDTO {
    private long totalAsset;
    private long totalDeposit;
    private long investmentAmount;
    private long investmentReturn;
}
