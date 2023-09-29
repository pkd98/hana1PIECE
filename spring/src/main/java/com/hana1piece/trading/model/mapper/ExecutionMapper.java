package com.hana1piece.trading.model.mapper;

import com.hana1piece.trading.model.vo.ExecutionVO;
import com.hana1piece.trading.model.vo.StoOrdersVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ExecutionMapper {

    List<ExecutionVO> findAll();
    List<ExecutionVO> getExecutionsByPage(@Param("offset") int offset, @Param("limit") int limit);

    void insertExecution(ExecutionVO executionVO);

    int getTotalExecutionCount();

}
