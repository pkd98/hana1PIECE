package com.hana1piece.member.model.dto;

import lombok.Data;

@Data
public class MembersTotalAssetDTO {
    private int walletNumber;
    private long asset; // 총 자산
    private double ROI; // 수익률
    private long deposit; // 예치금
    private long investmentAmount; // 투자금
    private long investmentReturn; // 투자 수익
}
