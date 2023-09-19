package com.hana1piece.trading;

import com.hana1piece.trading.controller.TradingController;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.fail;

@SpringBootTest
@Transactional
public class tradingTest {

    @Autowired
    private TradingController tradingController;

    @Test
    @DisplayName("예약 주문 스케줄러 테스트")
    void estate(){
        try {
            tradingController.orderForReservation();
        } catch(Exception e) {
            e.printStackTrace();
            fail("에러 발생" + e.getMessage());
        }
    }

}
