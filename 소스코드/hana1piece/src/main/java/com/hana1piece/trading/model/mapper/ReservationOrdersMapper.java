package com.hana1piece.trading.model.mapper;

import com.hana1piece.trading.model.vo.ReservationOrdersVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ReservationOrdersMapper {
    void insertReservation(ReservationOrdersVO reservationOrdersVO);
    List<ReservationOrdersVO> findAll();
    List<ReservationOrdersVO> findByWN(int WN);
    List<ReservationOrdersVO> findByLN(int LN);
    ReservationOrdersVO findById(int id);
    ReservationOrdersVO findByWNAndLN(@Param("WN")int WN, @Param("LN")int LN);
    void updateReservation(ReservationOrdersVO reservationOrdersVO);

}
