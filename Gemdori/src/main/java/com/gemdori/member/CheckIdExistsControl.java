package com.gemdori.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;
import com.gemdori.member.service.UserService;
import com.gemdori.member.service.UserServiceImpl;

public class CheckIdExistsControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("userId");
        UserService service = new UserServiceImpl();

        String userCode = service.findUserCodeByUserId(userId);
        PrintWriter out = resp.getWriter();
        resp.setContentType("text/plain;charset=UTF-8");

        // userId를 통해 가져온 userCode이 null 아닐 경우 
        if (userCode != null) {
        	// email <= userEmail 정보 저장
            String email = service.findEmailByUserCode(userCode);
            if (email != null) {
                String code = String.valueOf(new Random().nextInt(900000) + 100000);
                System.out.println("[비밀번호 찾기 인증 코드] " + code);
                HttpSession session = req.getSession();
                session.setAttribute("verifyCode", code);
                session.setAttribute("verifyUserCode", userCode);

                MailSender.sendMail(email, code);
                out.print("sent");
                return;
            }
        }
        out.print("notfound");
	}

}
