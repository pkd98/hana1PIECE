package com.hana1piece.manager.service;

import com.hana1piece.logger.service.LoggerService;
import com.hana1piece.manager.model.dto.ManagerLoginDTO;
import com.hana1piece.manager.model.mapper.ManagerMapper;
import com.hana1piece.manager.model.vo.ManagerVO;
import com.hana1piece.member.model.vo.OneMembersVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

@Service
public class ManagerServiceImpl implements ManagerService {

    private final ManagerMapper managerMapper;
    private final LoggerService loggerService;

    @Autowired
    public ManagerServiceImpl(ManagerMapper managerMapper, LoggerService loggerService) {
        this.managerMapper = managerMapper;
        this.loggerService = loggerService;
    }
    @Override
    public boolean login(ManagerLoginDTO loginDTO, HttpSession session) {
        try {
            ManagerVO manager = managerMapper.login(loginDTO);
            System.out.println(manager.toString());
            // 로그인 실패
            if (manager == null) {
                return false;
            } else { // 로그인 성공
                session.setAttribute("manager", manager);
                return true;
            }
        } catch (Exception e) {
            // 예기치 못한 에러
            loggerService.logException("ERR", "manager-login", e.getMessage(), "");
            e.printStackTrace();
            throw e;
        }
    }


}
