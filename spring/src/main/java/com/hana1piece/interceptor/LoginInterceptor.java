package com.hana1piece.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hana1piece.manager.model.vo.ManagerVO;
import com.hana1piece.member.model.vo.OneMembersVO;
import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {

    /*
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession();
        ManagerVO manager = (ManagerVO) session.getAttribute("manager");
        return (manager == null) ? false : true;
    }
     */


/*
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession();
//        System.out.println("preHandler - login check");
//        System.out.println(handler);
//        System.out.println(request.getContextPath());
//        System.out.println(request.getQueryString());
//        System.out.println(request.getServletPath());
//        System.out.println(request.getRequestURI());

        session.setAttribute("dest", request.getServletPath());

//        OneMembersVO member = (OneMembersVO) session.getAttribute("member");
//        if (member == null) { // 로그인 안한 경우
//            //response.sendRedirect(request.getContextPath() + "/login");
//            return false;
//        } else { // 한 경우
//            return true;
//        }
        return true;
    }

*/
}
