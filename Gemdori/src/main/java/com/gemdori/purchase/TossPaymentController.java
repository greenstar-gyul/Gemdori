package com.gemdori.purchase;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;
import com.gemdori.member.vo.UserFullVO;
import com.gemdori.purchase.service.GemdoriShoppingCartService;
import com.gemdori.purchase.service.GemdoriShoppingCartServiceImpl;
import com.gemdori.purchase.vo.GemdoriShoppingCartVO;

public class TossPaymentController implements Control {

    private GemdoriShoppingCartService cartService;
    // 토스페이먼츠 API 키 (테스트용)
    private static final String TOSS_CLIENT_KEY = "test_ck_DnyRpQWGrNla9B9klynl3Kwv1M9E";
    private static final String TOSS_SECRET_KEY = "test_sk_KNbdOvk5rk6QEgNPvK4yVn07xlzm:";

    public TossPaymentController() {
        this.cartService = new GemdoriShoppingCartServiceImpl();
    }

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 세션 가져오기
        HttpSession session = req.getSession();
        
        // 로그인 체크
        UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            resp.sendRedirect("login.do?redirect=cartPage.do");
            return;
        }
        
        String userCode = loginUser.getUserCode();
        
        try {
            // 장바구니 아이템 목록 조회
            List<GemdoriShoppingCartVO> cartItems = cartService.getCartItemsByUser(userCode);
            
            if (cartItems == null || cartItems.isEmpty()) {
                resp.sendRedirect("cartPage.do?error=empty_cart");
                return;
            }
            
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

            if (finalAmount < 0) {
                finalAmount = 0;
            }
            
            // 주문 ID 생성 (UUID 첫 부분)
            String orderId = "ORDER_" + UUID.randomUUID().toString().substring(0, 8);
            
            // 주문명 생성 (첫 번째 게임명 + 추가 개수)
            String orderName = cartItems.get(0).getGameTitle();
            if (cartItems.size() > 1) {
                orderName += " 외 " + (cartItems.size() - 1) + "건";
            }
            
            // 고객명
            String customerName = loginUser.getUserName();
            
            // 콜백 URL 생성
            String scheme = req.getScheme();
            String serverName = req.getServerName();
            int serverPort = req.getServerPort();
            String contextPath = req.getContextPath();
            
            String baseUrl = scheme + "://" + serverName;
            if (!((scheme.equals("http") && serverPort == 80) || (scheme.equals("https") && serverPort == 443))) {
                baseUrl += ":" + serverPort;
            }
            baseUrl += contextPath;
            
            String successUrl = baseUrl + "/paymentSuccess.do";
            String failUrl = baseUrl + "/paymentFail.do";
            
            // 결제 정보를 세션에 저장 (결제 검증용)
            session.setAttribute("paymentOrderId", orderId);
            session.setAttribute("paymentOrderName", orderName);
            session.setAttribute("paymentAmount", finalAmount);
            
            // 결제 정보를 뷰에 전달
            req.setAttribute("tossClientKey", TOSS_CLIENT_KEY);
            req.setAttribute("customerKey", userCode);
            req.setAttribute("paymentAmount", finalAmount);
            req.setAttribute("paymentOrderId", orderId);
            req.setAttribute("paymentOrderName", orderName);
            req.setAttribute("paymentCustomerName", customerName);
            req.setAttribute("paymentSuccessUrl", successUrl);
            req.setAttribute("paymentFailUrl", failUrl);
            req.setAttribute("cartItems", cartItems);
            
            // tossPayment.jsp로 포워딩
            req.getRequestDispatcher("purchase/tossPayment.tiles").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("cartPage.do?error=payment_error");
        }
    }
}