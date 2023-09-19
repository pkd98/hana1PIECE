package com.hana1piece.trading.model.dto;

import com.hana1piece.trading.model.vo.ReservationOrdersVO;
import lombok.Data;

@Data
public class ReservationOrderRequestDTO {
    private ReservationOrdersVO reservationOrdersVO;
    private String walletPassword;
}
