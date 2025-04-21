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
import com.gemdori.purchase.vo.GemdoriShoppingCartVO;

public class AddToCartControl implements Control {
    
    private GemdoriShoppingCartService cartService;
    
    public AddToCartControl() {
        this.cartService = new GemdoriShoppingCartServiceImpl();
    }
    
    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 응답 타입 설정
        resp.setContentType("text/plain; charset=UTF-8");
        PrintWriter out = resp.getWriter();
        
        // 세션에서 loginUser 객체 가져오기
        HttpSession session = req.getSession();
        UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser");
        
        // 로그인 체크
        if (loginUser == null) {
            out.print("login_required");
            return;
        }
        
        // loginUser에서 userCode 가져오기
        String userCode = loginUser.getUserCode();
        System.out.println("사용자 코드: " + userCode);
        
        try {
            // gameCode 파라미터만 받기
            String gameCode = req.getParameter("gameCode");
            
            if (gameCode == null || gameCode.isEmpty()) {
                out.print("invalid_param");
                return;
            }
            
            // 이미 장바구니에 존재하는지 확인
            boolean exists = cartService.checkExistingCart(userCode, gameCode);
            if (exists) {
                out.print("already_exists");
                return;
            }
            
            // 장바구니 객체 생성 및 설정
            GemdoriShoppingCartVO cartVO = new GemdoriShoppingCartVO();
            // cartCode는 이제 시퀀스로 생성되므로 설정하지 않음
            cartVO.setUserCode(userCode);
            cartVO.setGameCode(gameCode);
            
            // 장바구니에 추가
            boolean result = cartService.addItemToCart(cartVO);
            
            // buyNow 파라미터가 있으면 바로 결제 페이지로 리다이렉트
            String buyNow = req.getParameter("buyNow");
            if (result && "true".equals(buyNow)) {
                resp.sendRedirect("checkout.do");
                return;
            }
            
            if (result) {
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