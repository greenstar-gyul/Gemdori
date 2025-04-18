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
import com.gemdori.member.vo.UserSecurityVO;

public class LoginControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		// 이미 로그인된 경우 로그인 컨트롤 실행 차단
		if (session.getAttribute("loginUser") != null) {
			resp.sendRedirect("main.do");
			return;
		}
		
		String userId = req.getParameter("userId");
        String userPw = req.getParameter("userPw");

        UserService service = new UserServiceImpl();
        UserFullVO user = service.selectUser(userId, userPw);
        String userCode = service.findUserCodeByUserId(userId); // userCode 가져오기
        if (userCode == null) {
            // 아이디 자체가 존재하지 않을 경우
            session.setAttribute("loginError", "존재하지 않는 아이디입니다.");
            resp.sendRedirect("loginForm.do");
            return;
        }
        
        // userCode로 보안 정보 조회
     	UserSecurityVO security = service.getUserSecurity(userCode);
     	if (security == null) {
     	    session.setAttribute("loginError", "보안 정보가 존재하지 않습니다. 관리자에게 문의해주세요.");
     	    resp.sendRedirect("loginForm.do");
     	    return;
     	}
        
		if (security != null && security.getIsLocked() == -1) {
			req.getSession().setAttribute("loginError", "계정이 잠겨 있습니다. 비밀번호 찾기를 통한 재발급을 진행하세요.");
			resp.sendRedirect("loginForm.do");
			return;
		}
        
        System.out.println("로그인 시도: ID = " + userId + ", PW = " + userPw);
        System.out.println("로그인 결과: " + (user != null ? "성공" : "실패"));

		if (user != null) {
			// 로그인 성공 시 실패 횟수 초기화
			service.resetLoginFailCount(userCode);

			session.setAttribute("loginUser", user);
			resp.sendRedirect("main.do");
		} else {
			// 로그인 실패 시 실패 횟수 +1
			service.increaseLoginFailCount(userCode);
			int failCount = service.getLoginFailCount(userCode);

			if (failCount >= 5) {
				service.lockUserAccount(userCode);
				session.setAttribute("loginError", "5회 이상 실패하여 계정이 잠겼습니다.");
			} else {
				session.setAttribute("loginError", "아이디 또는 비밀번호가 올바르지 않습니다.");
			}
			resp.sendRedirect("loginForm.do");
		}
	}

}
