package com.hana1piece.manager.model.mapper;

import com.hana1piece.manager.model.dto.ManagerLoginDTO;
import com.hana1piece.manager.model.vo.ManagerVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ManagerMapper {
    ManagerVO login(ManagerLoginDTO managerLoginDTO);

}
