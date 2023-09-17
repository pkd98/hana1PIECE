package com.hana1piece.trading.model.mapper;

import com.hana1piece.trading.model.vo.ExecutionVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ExecutionMapper {

    List<ExecutionVO> findAll();
    
    void insertExecution(ExecutionVO executionVO);

}
