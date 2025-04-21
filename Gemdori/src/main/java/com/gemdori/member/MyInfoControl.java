package com.gemdori.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;
import com.gemdori.member.vo.UserFullVO;

public class MyInfoControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser");

        // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
        if (loginUser == null) {
        	resp.sendRedirect("loginForm.do");
            return;
        }

        // JSP에서 loginUser 정보 바로 사용할 수 있게 설정
        // 로그인 시 session에 'loginUser'로 넘김 => myInfo에서 'user'로 다시 넘김
        req.setAttribute("user", loginUser);
        // 회원정보 확인 페이지로 이동
        req.getRequestDispatcher("/member/myInfo.tiles").forward(req, resp);
        System.out.println("myInfo.do");
    }

	
}
