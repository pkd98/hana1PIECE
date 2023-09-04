package com.hana1piece.logger.service;

import com.hana1piece.logger.model.mapper.LoggerMapper;
import com.hana1piece.logger.model.vo.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class LoggerService {

    private LoggerMapper loggerMapper;

    @Autowired
    LoggerService(LoggerMapper loggerMapper) {
        this.loggerMapper = loggerMapper;
    }

    @Transactional
    public void logging(Log log) {
        loggerMapper.insertLog(log);
    }
}
