package com.hana1piece.trading.service;

import com.hana1piece.trading.model.vo.ReservationOrdersVO;

import java.util.List;

public interface ReservationOrderService {

    void insertReservation(ReservationOrdersVO reservationOrdersVO);
    List<ReservationOrdersVO> findAll();
    List<ReservationOrdersVO> findByWN(int WN);
    List<ReservationOrdersVO> findByLN(int LN);
    ReservationOrdersVO findById(int id);
    ReservationOrdersVO findByWNAndLN(int WN, int LN);
    void updateReservation(ReservationOrdersVO reservationOrdersVO);

}
