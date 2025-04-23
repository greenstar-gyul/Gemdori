package com.gemdori.purchase;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;
import com.gemdori.member.vo.UserFullVO;
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
        
        HttpSession session = req.getSession();
        UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser");
        
        // 로그인 체크
        if (loginUser == null || loginUser.getUserCode() == null || loginUser.getUserCode().isEmpty()) {
            out.print("login_required");
            return;
        }
        
        String userCode = loginUser.getUserCode();
        
        try {
            // cartCode 파라미터
            String cartCode = req.getParameter("cartCode");
            System.out.println("삭제 요청 cartCode: [" + cartCode + "]");
            
            // cartCode 유효성 검사
            if (cartCode == null || cartCode.isEmpty()) {
                out.print("invalid_param");
                return;
            }

            // 장바구니 아이템 삭제
            boolean result = cartService.removeCartItemByCartCode(cartCode);
            
            // 아이템이 삭제되었다면, 세션에서도 해당 아이템 제거
            if (result) {
                // 세션에 저장된 장바구니 정보가 있다면 제거
                session.removeAttribute("cartItems");
                
                // 결과 응답
                out.print("success");
            } else {
                out.print("fail");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("error");
        }
    }
}