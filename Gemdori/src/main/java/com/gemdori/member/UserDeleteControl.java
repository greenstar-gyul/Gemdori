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

public class UserDeleteControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser");

        if (loginUser == null) {
            resp.sendRedirect("loginForm.do");
            return;
        }

        String userCode = loginUser.getUserCode();
        String inputPw = req.getParameter("userPw");

        UserService service = new UserServiceImpl
        		();

        // 비밀번호 일치 여부 검증
        boolean validPw = service.checkPassword(userCode, inputPw);

        if (!validPw) {
            req.setAttribute("error", "비밀번호가 일치하지 않습니다.");
            req.getRequestDispatcher("/member/userDeleteForm.tiles").forward(req, resp);
            return;
        }

        // 탈퇴 처리 (status -1로 변경)
        boolean result = service.deleteUser(userCode);
        if (result) {
            session.invalidate();
            resp.sendRedirect("loginForm.do?message=withdrawSuccess");
        } else {
            req.setAttribute("error", "회원탈퇴 처리에 실패했습니다.");
            req.getRequestDispatcher("/member/userDeleteForm.tiles").forward(req, resp);
        }
    }
}


