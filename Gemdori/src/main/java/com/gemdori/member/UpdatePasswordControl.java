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

public class UpdatePasswordControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
        UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser");

        if (loginUser == null) {
            resp.sendRedirect("loginForm.do");
            return;
        }

        String userCode = loginUser.getUserCode();
        String currentPw = req.getParameter("currentPassword");
        String newPw = req.getParameter("newPassword");
        String confirmPw = req.getParameter("confirmPassword");

        // 새 비밀번호 일치 여부 확인
        if (newPw == null || !newPw.equals(confirmPw)) {
            req.setAttribute("error", "새 비밀번호가 일치하지 않습니다.");
            req.getRequestDispatcher("/member/updatePasswordForm.tiles").forward(req, resp);
            return;
        }

        // 비밀번호 변경 시도
        UserService service = new UserServiceImpl();
        boolean result = service.changePassword(userCode, currentPw, newPw);

        if (result) {
            // 비밀번호 변경 성공 시 로그아웃 후 로그인 폼 이동
            session.invalidate();
            resp.sendRedirect("loginForm.do?message=changeSuccess");
        } else {
            // 기존 비밀번호 불일치 등 실패
            req.setAttribute("error", "기존 비밀번호가 일치하지 않거나 변경에 실패했습니다.");
            req.getRequestDispatcher("/member/updatePasswordForm.tiles").forward(req, resp);
        }
    }
}
