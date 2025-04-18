package com.gemdori.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gemdori.common.Control;
import com.gemdori.member.service.UserService;
import com.gemdori.member.service.UserServiceImpl;
import com.gemdori.member.vo.UserProfileVO;
import com.gemdori.member.vo.UserSecurityVO;
import com.gemdori.member.vo.UserSignVO;

public class JoinControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/json;charset=utf-8");
		// 1. 파라미터 수집
		String userId = req.getParameter("userId");
		String userPw = req.getParameter("userPw");
		String userName = req.getParameter("userName");
		String firstName = req.getParameter("userFirstName");
		String lastName = req.getParameter("userLastName");
		String userEmail = req.getParameter("userEmail");
		String userPhone = req.getParameter("userPhone");
		String userBirthday = req.getParameter("userBirthday");
		String userGender = req.getParameter("userGender");

        // 2. 서비스 호출
        UserService service = new UserServiceImpl();

        UserSignVO signVO = new UserSignVO();
        signVO.setUserId(userId);
        signVO.setUserPw(userPw);

        boolean isSignSuccess = service.addUserSign(signVO);

        if (isSignSuccess) {
            UserProfileVO profileVO = new UserProfileVO();
            profileVO.setUserCode(signVO.getUserCode()); // selectKey로 설정된 값
            profileVO.setUserName(userName);
            profileVO.setUserFirstName(firstName);
            profileVO.setUserLastName(lastName);
            profileVO.setUserEmail(userEmail);
            profileVO.setUserPhone(userPhone);
            profileVO.setUserGender(userGender);

            // 생일은 문자열로 넘어오기 때문에 Date로 변환
            try {
                if (userBirthday != null && !userBirthday.isEmpty()) {
                    profileVO.setUserBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(userBirthday));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            boolean isProfileSuccess = service.addUserProfile(profileVO);
            // 보안 테이블 insert
         	UserSecurityVO securityVO = new UserSecurityVO();
         	securityVO.setUserCode(signVO.getUserCode());
         	securityVO.setLoginFailCount(0); // 기본값
         	securityVO.setIsLocked(1);       // 잠김 아님

         	boolean isSecuritySuccess = service.addUserSecurity(securityVO);
            
			if (isProfileSuccess && isSecuritySuccess) {
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>");
				out.println("alert('회원가입이 완료되었습니다. 로그인 페이지로 이동합니다.');");
				out.println("location.href='loginForm.do';");
				out.println("</script>");
				return;
			}
        }

        // 실패 시
        resp.sendRedirect("signForm.do");

	}

}
