package com.hana1piece.logger;

import com.hana1piece.logger.model.vo.Log;
import com.hana1piece.logger.service.LoggerService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.fail;

/**
 *  Oracle - Mybatis  통합 테스트
 *  LoggerService 예외 로그 작성 테스트
 */
@SpringBootTest
@Transactional
public class LoggerTest {

    @Autowired
    private LoggerService loggerService;

    @Test
    @DisplayName("LoggerService 예외 로그 작성 테스트")
    void insertLogTest(){
        Log log = new Log();
        log.setLogCode("err");
        log.setProgram("Test");
        log.setMsg("logger test");
        log.setNote("test");

        try {
            loggerService.logging(log);
        } catch(Exception e) {
            fail("로깅중 에러 발생" + e.getMessage());
        }
    }
}
