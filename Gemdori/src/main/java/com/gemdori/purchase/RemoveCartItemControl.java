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

public class RemoveCartItemControl implements Control {
    
    private GemdoriShoppingCartService cartService;
    
    public RemoveCartItemControl() {
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
        
        // 로그인 체크
        if (userCode == null || userCode.isEmpty()) {
            out.print("login_required");
            return;
        }
        
        try {
            // gameCode 파라미터 받기
            String gameCode = req.getParameter("gameCode");
            
            // cartCode 파라미터 (삭제용)
            String cartCode = req.getParameter("cartCode");
            
            // gameCode만 있는 경우 게임코드로 삭제
            if (gameCode != null && !gameCode.isEmpty()) {
                boolean result = cartService.removeCartItem(userCode, gameCode);
                
                if (result) {
                    out.print("success");
                } else {
                    out.print("fail");
                }
                return;
            }
            
            // 장바구니 삭제 실패
            out.print("invalid_param");
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("error");
        }
    }
}