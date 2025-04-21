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

        // 이미 로그인된 경우 차단
        if (session.getAttribute("loginUser") != null) {
            resp.sendRedirect("main.do");
            return;
        }

        // 사용자 입력값 수집
        String userId = req.getParameter("userId");
        String userPw = req.getParameter("userPw");

        UserService service = new UserServiceImpl();
        String userCode = service.findUserCodeByUserId(userId); // userCode 먼저 조회
        
        // userCode 없는 경우 바로 리턴
        if (userCode == null) {
            session.setAttribute("loginError", "존재하지 않는 아이디입니다.");
            resp.sendRedirect("loginForm.do");
            return;
        }

        // 보안 정보 조회 (login_fail_count, is_locked 등)
        UserSecurityVO security = service.getUserSecurity(userCode);

        // 계정 잠김 상태 확인
        if (security != null && security.getIsLocked() == -1) {
            session.setAttribute("loginError", "계정이 잠겨 있습니다. 관리자에게 문의하세요.");
            resp.sendRedirect("loginForm.do");
            return;
        }

        // 로그인 시도
        UserFullVO user = service.selectUser(userId, userPw);

        System.out.println("로그인 시도: ID = " + userId);
        System.out.println("로그인 결과: " + (user != null ? "성공" : "실패"));

        if (user != null) { // 로그인 실패 시 user은 null
            // 로그인 성공 시 login_fail_count 초기화
            service.resetLoginFailCount(userCode);
            service.updateLastLoginDate(userCode); // 마지막 로그인 시간 기록

            // 불필요한 loginUser session 정보 제거
            user.setUserPw(null);
            user.setLoginFailCount(0);
            user.setIsLocked(0);
            
            session.setAttribute("loginUser", user); // user정보 session 저장
            resp.sendRedirect("main.do");
        } else {
            // 🔐 로그인 실패 시 실패 횟수 증가
            service.increaseLoginFailCount(userCode);
            int failCount = service.getLoginFailCount(userCode);

            // 5회 이상 실패 시 계정 잠금
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
