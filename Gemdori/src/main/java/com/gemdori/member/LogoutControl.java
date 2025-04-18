package com.gemdori.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;

public class LogoutControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false); // false: 세션 없으면 null 반환
        if (session != null) {
            session.invalidate(); // 세션 전체 제거
        }
        resp.sendRedirect("loginForm.do"); // 로그인 페이지로 리다이렉트

	}

}
