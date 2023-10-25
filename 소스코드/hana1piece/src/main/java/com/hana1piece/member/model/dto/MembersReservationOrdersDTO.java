package com.hana1piece.member.model.dto;

import com.hana1piece.estate.model.vo.RealEstateInfoVO;
import com.hana1piece.trading.model.vo.ReservationOrdersVO;
import lombok.Data;

@Data
public class MembersReservationOrdersDTO {
    private ReservationOrdersVO reservationOrdersVO;
    private RealEstateInfoVO realEstateInfoVO;
}
