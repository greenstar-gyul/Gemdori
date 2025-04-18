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
import com.gemdori.vo.GemdoriShoppingCartVO;

public class CartPageControl implements Control {
    
    private GemdoriShoppingCartService cartService;
    
    // 기본 생성자 - 서비스 객체를 생성해서 초기화
    public CartPageControl() {
        this.cartService = new GemdoriShoppingCartServiceImpl();
    }
    
    // 테스트용 생성자 (의존성 주입)
    public CartPageControl(GemdoriShoppingCartService cartService) {
        this.cartService = cartService;
    }

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 세션에서 사용자 코드 가져오기
        HttpSession session = req.getSession();
        String userCode = (String) session.getAttribute("userCode");
        
        // userCode가 없을 경우 빈 처리 (로그인 필요 메시지나 리다이렉트 등 가능)
        if (userCode != null) {
            // 장바구니 아이템 조회
            List<GemdoriShoppingCartVO> cartItems = cartService.getCartItemsByUser(userCode);
            req.setAttribute("cartItems", cartItems);
            
            // 총액계산 , 할인 계산
            int totalAmount = cartService.getCartTotalAmount(userCode);
            int discountAmount = cartService.getCartDiscountAmount(userCode);
            
            req.setAttribute("totalAmount", totalAmount);
            req.setAttribute("discountAmount", discountAmount);
        } else {
            // 로그인하지 않은 경우 빈 목록 설정 또는 메시지 설정
            req.setAttribute("cartItems", List.of());
            req.setAttribute("totalAmount", 0);
            req.setAttribute("discountAmount", 0);
            // 필요하다면 로그인 필요 메시지 추가
            req.setAttribute("message", "장바구니를 보려면 로그인이 필요합니다.");
        }
        
        req.getRequestDispatcher("purchase/cartPage.tiles").forward(req, resp);
    }
}