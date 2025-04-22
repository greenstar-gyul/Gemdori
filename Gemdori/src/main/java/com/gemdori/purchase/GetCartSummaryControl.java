package com.gemdori.purchase;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.gemdori.common.Control;
import com.gemdori.member.vo.UserFullVO;
import com.gemdori.purchase.service.GemdoriShoppingCartService;
import com.gemdori.purchase.service.GemdoriShoppingCartServiceImpl;

public class GetCartSummaryControl implements Control {
    
    private GemdoriShoppingCartService cartService;
    
    public GetCartSummaryControl() {
        this.cartService = new GemdoriShoppingCartServiceImpl();
    }

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json; charset=UTF-8");
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        PrintWriter out = resp.getWriter();
        
        HttpSession session = req.getSession();
        UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser");
        
        if (loginUser == null || loginUser.getUserCode() == null) {
            out.print("{\"error\":\"login_required\"}");
            return;
        }
        
        String userCode = loginUser.getUserCode();
        
        try {
        	Map<String, Object> cartSummary = cartService.getCartTotalAmount(userCode);

        	int totalAmount = 0;
        	int discountAmount = 0;
        	int finalAmount = 0;

        	// BigDecimal을 안전하게 int로 변환
        	if (cartSummary.get("TOTAL_ORIGINAL_PRICE") != null) {
        	    if (cartSummary.get("TOTAL_ORIGINAL_PRICE") instanceof BigDecimal) {
        	        totalAmount = ((BigDecimal) cartSummary.get("TOTAL_ORIGINAL_PRICE")).intValue();
        	    } else if (cartSummary.get("TOTAL_ORIGINAL_PRICE") instanceof Integer) {
        	        totalAmount = (Integer) cartSummary.get("TOTAL_ORIGINAL_PRICE");
        	    }
        	}

        	if (cartSummary.get("TOTAL_DISCOUNT") != null) {
        	    if (cartSummary.get("TOTAL_DISCOUNT") instanceof BigDecimal) {
        	        discountAmount = ((BigDecimal) cartSummary.get("TOTAL_DISCOUNT")).intValue();
        	    } else if (cartSummary.get("TOTAL_DISCOUNT") instanceof Integer) {
        	        discountAmount = (Integer) cartSummary.get("TOTAL_DISCOUNT");
        	    }
        	}

        	if (cartSummary.get("TOTAL_PAYMENT") != null) {
        	    if (cartSummary.get("TOTAL_PAYMENT") instanceof BigDecimal) {
        	        finalAmount = ((BigDecimal) cartSummary.get("TOTAL_PAYMENT")).intValue();
        	    } else if (cartSummary.get("TOTAL_PAYMENT") instanceof Integer) {
        	        finalAmount = (Integer) cartSummary.get("TOTAL_PAYMENT");
        	    }
        	}

        	int itemCount = cartService.getCartItemCount(userCode);
            
            JSONObject json = new JSONObject();
            json.put("totalAmount", totalAmount);
            json.put("discountAmount", discountAmount);
            json.put("finalAmount", finalAmount); // 추가: 최종 금액도 전달
            json.put("itemCount", itemCount);
            
            out.print(json.toJSONString());
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"error\":\"system_error\"}");
        }
    }
}