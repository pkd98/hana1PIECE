package com.hana1piece.trading.service;

import com.hana1piece.trading.model.mapper.ReservationOrdersMapper;
import com.hana1piece.trading.model.vo.ReservationOrdersVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ReservationOrderServiceImpl implements ReservationOrderService {

    private final ReservationOrdersMapper reservationOrdersMapper;

    @Autowired
    public ReservationOrderServiceImpl(ReservationOrdersMapper reservationOrdersMapper) {
        this.reservationOrdersMapper = reservationOrdersMapper;
    }

    @Override
    public void insertReservation(ReservationOrdersVO reservationOrdersVO) {
        reservationOrdersMapper.insertReservation(reservationOrdersVO);
    }

    @Override
    public List<ReservationOrdersVO> findAll() {
        return reservationOrdersMapper.findAll();
    }

    @Override
    public List<ReservationOrdersVO> findByWN(int WN) {
        return reservationOrdersMapper.findByWN(WN);
    }

    @Override
    public List<ReservationOrdersVO> findByLN(int LN) {
        return reservationOrdersMapper.findByLN(LN);
    }

    @Override
    public ReservationOrdersVO findById(int id) {
        return reservationOrdersMapper.findById(id);
    }

    @Override
    public ReservationOrdersVO findByWNAndLN(int WN, int LN) {
        return reservationOrdersMapper.findByWNAndLN(WN, LN);
    }

    @Override
    public void updateReservation(ReservationOrdersVO reservationOrdersVO) {
        reservationOrdersMapper.updateReservation(reservationOrdersVO);
    }
}
