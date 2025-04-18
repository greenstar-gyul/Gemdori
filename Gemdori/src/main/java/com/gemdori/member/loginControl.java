package com.gemdori.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;
import com.gemdori.member.service.UserService;
import com.gemdori.member.service.UserServiceImpl;
import com.gemdori.member.vo.UserFullVO;

public class loginControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("userId");
        String userPw = req.getParameter("userPw");

        UserService service = new UserServiceImpl();
        UserFullVO user = service.selectUser(userId, userPw);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("loginUser", user);

            resp.sendRedirect("main.do");
        } else {
            req.setAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다.");
            req.getRequestDispatcher("loginForm.do").forward(req, resp);
        }
	}

}
