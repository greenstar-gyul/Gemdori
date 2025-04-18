package com.gemdori.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;

public class SendEmailControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 1. 인증 코드 생성
		String email = req.getParameter("email");
        String code = String.valueOf(new Random().nextInt(900000) + 100000); // 6자리 숫자
        // 2. 세션에 저장
        HttpSession session = req.getSession();
        session.setAttribute("verifyCode", code);  // code는 전송된 인증번호 문자열
        
        System.out.println("[회원가입 인증 코드] " + code);
        // 3. 이메일 전송
        MailSender.sendMail(email, code); // 메일 전송 로직 호출
        // 4. 응답
        resp.setContentType("text/plain;charset=utf-8");
        PrintWriter out = resp.getWriter();
        out.print(code); // 클라이언트로 코드 반환

	}

}
