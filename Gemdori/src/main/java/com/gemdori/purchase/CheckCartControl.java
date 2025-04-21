package com.gemdori.purchase;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;
import com.gemdori.purchase.service.GemdoriShoppingCartService;
import com.gemdori.purchase.service.GemdoriShoppingCartServiceImpl;

public class CheckCartControl implements Control {
    
    private GemdoriShoppingCartService cartService;
    
    public CheckCartControl() {
        this.cartService = new GemdoriShoppingCartServiceImpl();
    }
    
    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 응답 타입 설정
        resp.setContentType("text/plain; charset=UTF-8");
        PrintWriter out = resp.getWriter();
        
        // 세션에서 사용자 코드 가져오기
        HttpSession session = req.getSession();
        String userCode = (String) session.getAttribute("userCode");
        
        // 결과 기본값 설정
        String result = "false";
        
        // 로그인 체크 및 gameCode 파라미터 확인
        if (userCode != null && !userCode.isEmpty()) {
            String gameCode = req.getParameter("gameCode");
            
            if (gameCode != null && !gameCode.isEmpty()) {
                try {
                    // 장바구니에 존재하는지 확인
                    boolean exists = cartService.checkExistingCart(userCode, gameCode);
                    result = exists ? "true" : "false";
                } catch (Exception e) {
                    e.printStackTrace();
                    result = "error";
                }
            }
        }
        
        // 결과 출력
        out.print(result);
    }
}