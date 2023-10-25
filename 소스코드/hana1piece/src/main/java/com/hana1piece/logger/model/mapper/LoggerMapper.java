package com.hana1piece.logger.model.mapper;

import com.hana1piece.logger.model.vo.Log;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoggerMapper {
    void insertLog(Log log);
}
