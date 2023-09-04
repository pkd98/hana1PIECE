package com.hana1piece.logger.service;

import com.hana1piece.logger.model.mapper.LoggerMapper;
import com.hana1piece.logger.model.vo.Log;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class LoggerService {

    private LoggerMapper loggerMapper;
    private final Logger logger = LoggerFactory.getLogger(this.getClass());


    @Autowired
    public LoggerService(LoggerMapper loggerMapper) {
        this.loggerMapper = loggerMapper;
    }

    public void logException(String logCode, String program, String msg, String note) {
        // 예외 발생 시 로그 저장
        Log log = new Log();
        log.setLogCode(logCode);
        log.setProgram(program);
        log.setMsg(msg);
        log.setNote(note);
        logging(log);
    }

    @Transactional
    public void logging(Log log) {
        loggerMapper.insertLog(log);
        logger.info("로그 저장 완료: {}", log.getMsg()); // 콘솔에 출력됨
    }
}
