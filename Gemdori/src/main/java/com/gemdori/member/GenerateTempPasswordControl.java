package com.gemdori.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;
import com.gemdori.member.service.UserService;
import com.gemdori.member.service.UserServiceImpl;

public class GenerateTempPasswordControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String userCode = (String) session.getAttribute("verifyUserCode");

		resp.setContentType("text/plain;charset=UTF-8");
		PrintWriter out = resp.getWriter();

		if (userCode == null) {
			out.print("unauthorized");
			return;
		}

		if (userCode != null) {
			// 1. 임시 비밀번호 생성
			String tempPw = PasswordGenerator.generate(12);

			// 2. DB 업데이트
			UserService service = new UserServiceImpl();
			boolean pwUpdated = service.updateUserPassword(userCode, tempPw); // 임시 비밀번호 저장
			// 보안 정보 초기화
			boolean securityReset = service.resetSecurityAfterPwUpdate(userCode);

			if (pwUpdated && securityReset) {
				out.print(tempPw); // JS로 전송
			} else {
				System.out.println("[ERROR] 비밀번호 업데이트 또는 보안정보 초기화 실패");
				out.print("error");
			}
		}
	}
}
