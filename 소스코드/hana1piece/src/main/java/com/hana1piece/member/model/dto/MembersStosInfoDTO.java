package com.hana1piece.member.model.dto;

import lombok.Data;

@Data
public class MembersStosInfoDTO {
    private int walletNumber;
    private int listingNumber;
    private String buildingName; // 빌딩명
    private long profit; // 평가손익
    private double ROI; // 수익률
    private int amount; // 보유수량
    private int currentPrice; // 현재가
    private long assessmentAmount; // 평가금액
    private long avgBuyPrice; // 매수금액
}