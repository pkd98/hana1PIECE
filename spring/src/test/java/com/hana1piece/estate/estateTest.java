package com.hana1piece.estate;

import com.hana1piece.estate.controller.EstateController;
import com.hana1piece.logger.model.vo.Log;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.fail;

@SpringBootTest
// @Transactional
public class estateTest {

    @Autowired
    private EstateController estateController;

    @Test
    @DisplayName("estate 평가 서버 연동 및 스케줄러 테스트")
    void estate(){
        try {
            estateController.estateEvaluation();
        } catch(Exception e) {
            e.printStackTrace();
            fail("에러 발생" + e.getMessage());
        }
    }
}
