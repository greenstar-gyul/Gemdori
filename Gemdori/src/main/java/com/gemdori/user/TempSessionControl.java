package com.gemdori.user; // 패키지명은 프로젝트에 맞게 수정하세요

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;

public class TempSessionControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 세션 가져오기
        HttpSession session = req.getSession();
        
        // 임시 유저 코드 설정 (테스트용)
        String userCode = req.getParameter("userCode");
        if (userCode == null || userCode.isEmpty()) {
            userCode = "U2"; // 기본값 설정
        }
        
        // 세션에 유저 코드 저장
        session.setAttribute("userCode", userCode);
        
        // 세션에 저장된 값 확인용 메시지
        req.setAttribute("message", "사용자 코드 " + userCode + "가 세션에 저장되었습니다.");
        
        // 장바구니 페이지로 리다이렉트
        resp.sendRedirect("cartPage.do");
    }
}