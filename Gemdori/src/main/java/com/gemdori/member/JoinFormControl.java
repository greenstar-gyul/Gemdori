package com.gemdori.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;

public class JoinFormControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		// 로그인 상태일 경우 main.do로 리다이렉트
        if (session.getAttribute("loginUser") != null) {
            resp.sendRedirect("main.do");
            return; // 더 이상 진행 안 함
        }
		
		// TODO Auto-generated method stub
		req.getRequestDispatcher("member/signUp.tiles").forward(req, resp);
		System.out.println("signForm.do");
	}

}
