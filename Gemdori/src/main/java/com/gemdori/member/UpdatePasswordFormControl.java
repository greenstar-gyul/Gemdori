package com.gemdori.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;
import com.gemdori.member.vo.UserFullVO;

public class UpdatePasswordFormControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
        UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser");

        if (loginUser == null) {
        	resp.sendRedirect("loginForm.do");
            return;
        }

        // 로그인 시 session에 'loginUser'로 넘김 => myInfo에서 'user'로 다시 넘김
        req.setAttribute("user", loginUser);
        // 회원정보 확인 페이지로 이동
        req.getRequestDispatcher("/member/updatePasswordForm.tiles").forward(req, resp);
        System.out.println("updatePasswordForm.do");
	}

}
