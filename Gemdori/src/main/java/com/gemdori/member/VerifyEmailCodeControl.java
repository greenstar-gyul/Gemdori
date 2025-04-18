package com.gemdori.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;

public class VerifyEmailCodeControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json;charset=utf-8");

        String userInputCode = req.getParameter("code");
        HttpSession session = req.getSession();
        String sessionCode = (String) session.getAttribute("verifyCode");
        
        PrintWriter out = resp.getWriter();

        if (sessionCode != null && sessionCode.trim().equals(userInputCode.trim())) {
        	session.removeAttribute("verifyCode");
        	out.print("{\"status\":\"success\"}");
        } else {
        	out.print("{\"status\":\"fail\"}");
        }

	}

}
