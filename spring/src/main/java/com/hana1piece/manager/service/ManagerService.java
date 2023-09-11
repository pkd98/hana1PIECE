package com.hana1piece.manager.service;

import com.hana1piece.manager.model.dto.ManagerLoginDTO;

import javax.servlet.http.HttpSession;

public interface ManagerService {
    /**
     *  로그인
     */
    boolean login(ManagerLoginDTO loginDTO, HttpSession session);

}
