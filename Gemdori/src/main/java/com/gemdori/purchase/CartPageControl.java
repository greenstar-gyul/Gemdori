package com.gemdori.purchase;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;
import com.gemdori.purchase.service.GemdoriShoppingCartService;
import com.gemdori.purchase.service.GemdoriShoppingCartServiceImpl;
import com.gemdori.purchase.vo.GemdoriShoppingCartVO;
import com.gemdori.member.vo.UserFullVO; // 이 import 추가 필요 (패키지명은 실제 UserFullVO가 있는 패키지로 수정)

public class CartPageControl implements Control {
    
    private GemdoriShoppingCartService cartService;
    
    public CartPageControl() {
        this.cartService = new GemdoriShoppingCartServiceImpl();
    }
    
    public CartPageControl(GemdoriShoppingCartService cartService) {
        this.cartService = cartService;
    }

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 세션에서 loginUser 객체 가져오기
        HttpSession session = req.getSession();
        UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser");
        
        // loginUser가 null이거나 userCode가 없으면 로그인 페이지로 리다이렉트
        if (loginUser == null) {
            resp.sendRedirect("login.do?redirect=cartPage.do");
            return;
        }
        
        // loginUser에서 userCode 가져오기
        String userCode = loginUser.getUserCode();
        System.out.println("사용자 코드: " + userCode);
        
        try {
            // 장바구니 아이템 조회
            List<GemdoriShoppingCartVO> cartItems = cartService.getCartItemsByUser(userCode);
            req.setAttribute("cartItems", cartItems);
            System.out.println("아이템 코드: " + cartItems);
            // 총액계산, 할인 계산
            int totalAmount = cartService.getCartTotalAmount(userCode);
            int discountAmount = cartService.getCartDiscountAmount(userCode);
            
            req.setAttribute("totalAmount", totalAmount);
            req.setAttribute("discountAmount", discountAmount);
            
            // 페이지 표시
            req.getRequestDispatcher("purchase/cartPage.tiles").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("main.do?error=cart_error");
        }
    }
}