package com.gemdori.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gemdori.common.Control;
import com.gemdori.member.service.UserService;
import com.gemdori.member.service.UserServiceImpl;

public class CheckIdControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String userId = req.getParameter("userId");

        UserService service = new UserServiceImpl();
        boolean isAvailable = service.checkUserId(userId); // 이 메서드는 중복 여부 반환

        resp.setContentType("text/plain;charset=UTF-8");
        resp.getWriter().write(isAvailable ? "usable" : "taken");

	}

}
