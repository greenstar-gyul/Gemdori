package com.gemdori.purchase;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.gemdori.common.Control;
import com.gemdori.member.vo.UserFullVO;
import com.gemdori.purchase.service.GemdoriShoppingCartService;
import com.gemdori.purchase.service.GemdoriShoppingCartServiceImpl;
import com.gemdori.purchase.service.PaymentService;
import com.gemdori.purchase.vo.GemdoriShoppingCartVO;

public class PaymentSuccessControl implements Control {

    private GemdoriShoppingCartService cartService;
    private PaymentService paymentService;
    private static final String TOSS_SECRET_KEY = "test_sk_KNbdOvk5rk6QEgNPvK4yVn07xlzm:";
    
    public PaymentSuccessControl() {
        this.cartService = new GemdoriShoppingCartServiceImpl();
        this.paymentService = new PaymentService();
    }
    
    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 세션 가져오기
        HttpSession session = req.getSession();
        
        // 로그인 체크
        UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            resp.sendRedirect("login.do");
            return;
        }
        
        String userCode = loginUser.getUserCode();
        
        try {
            // 토스페이먼츠로부터 받은 파라미터들
            String paymentKey = req.getParameter("paymentKey");
            String orderId = req.getParameter("orderId");
            String amount = req.getParameter("amount");
            
            System.out.println("결제 성공 파라미터: paymentKey=" + paymentKey + ", orderId=" + orderId + ", amount=" + amount);
            
            // 세션에 저장된 주문정보 검증
            String sessionOrderId = (String) session.getAttribute("paymentOrderId");
            Integer sessionAmount = (Integer) session.getAttribute("paymentAmount");
            
            // 0원 주문일 경우 (무료 게임)
            if ("FREE_ORDER".equals(paymentKey)) {
                handleFreeOrder(req, resp, userCode, orderId);
                return;
            }
            
            // 주문정보 검증
            if (!orderId.equals(sessionOrderId) || Integer.parseInt(amount) != sessionAmount) {
                // 주문정보 불일치 (보안 위반 가능성)
                handlePaymentError(req, resp, "VALIDATION_FAILED", "주문 정보가 일치하지 않습니다.");
                return;
            }
            
            // 토스페이먼츠 결제 승인 API 호출
            JSONObject paymentResult = confirmPayment(paymentKey, orderId, amount);
            
            if (paymentResult == null) {
                // API 호출 실패
                handlePaymentError(req, resp, "API_ERROR", "결제 승인 API 호출에 실패했습니다.");
                return;
            }
            
            // 결제 상태 확인
            String status = (String) paymentResult.get("status");
            if (!"DONE".equals(status)) {
                // 결제 상태가 완료가 아님
                String errorCode = (String) paymentResult.get("code");
                String errorMessage = (String) paymentResult.get("message");
                handlePaymentError(req, resp, errorCode, errorMessage);
                return;
            }
            
            // 결제 성공 시 구매 내역 저장
            List<GemdoriShoppingCartVO> cartItems = cartService.getCartItemsByUser(userCode);
            boolean saved = paymentService.saveGamePurchaseHistory(userCode, paymentResult, cartItems);
            
            if (saved) {
                // 장바구니 비우기
                cartService.clearCart(userCode);
                
                // 결제 성공 화면으로 이동
                req.setAttribute("isSuccess", true);
                req.setAttribute("jsonObject", paymentResult);
                req.getRequestDispatcher("purchase/success.tiles").forward(req, resp);
            } else {
                // 구매 내역 저장 실패
                handlePaymentError(req, resp, "DB_ERROR", "구매 내역 저장에 실패했습니다.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            handlePaymentError(req, resp, "SYSTEM_ERROR", "시스템 오류가 발생했습니다.");
        }
    }
    
    // 무료 주문 처리
    private void handleFreeOrder(HttpServletRequest req, HttpServletResponse resp, String userCode, String orderId) 
            throws ServletException, IOException {
        try {
            // 장바구니 아이템 목록 조회
            List<GemdoriShoppingCartVO> cartItems = cartService.getCartItemsByUser(userCode);
            
            if (cartItems == null || cartItems.isEmpty()) {
                handlePaymentError(req, resp, "EMPTY_CART", "장바구니가 비어있습니다.");
                return;
            }
            
            // 임시 JSON 객체 생성 (무료 주문용)
            JSONObject freeOrderResult = new JSONObject();
            freeOrderResult.put("orderId", orderId);
            freeOrderResult.put("method", "무료");
            freeOrderResult.put("totalAmount", 0);
            freeOrderResult.put("status", "DONE");
            
            // 구매 내역 저장
            boolean saved = paymentService.saveGamePurchaseHistory(userCode, freeOrderResult, cartItems);
            
            if (saved) {
                // 장바구니 비우기
                cartService.clearCart(userCode);
                
                // 결제 성공 화면으로 이동
                req.setAttribute("isSuccess", true);
                req.setAttribute("jsonObject", freeOrderResult);
                req.getRequestDispatcher("purchase/success.tiles").forward(req, resp);
            } else {
                // 구매 내역 저장 실패
                handlePaymentError(req, resp, "DB_ERROR", "구매 내역 저장에 실패했습니다.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            handlePaymentError(req, resp, "SYSTEM_ERROR", "시스템 오류가 발생했습니다.");
        }
    }
    
    // 결제 오류 처리
    private void handlePaymentError(HttpServletRequest req, HttpServletResponse resp, String code, String message) 
            throws ServletException, IOException {
        
        JSONObject errorData = new JSONObject();
        errorData.put("code", code);
        errorData.put("message", message);
        
        req.setAttribute("isSuccess", false);
        req.setAttribute("jsonObject", errorData);
        req.getRequestDispatcher("purchase/success.tiles").forward(req, resp);
    }
    
    // 토스페이먼츠 결제 승인 API 호출
    private JSONObject confirmPayment(String paymentKey, String orderId, String amount) {
        try {
            // API URL 설정
            URL url = new URL("https://api.tosspayments.com/v1/payments/" + paymentKey);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            
            // 인증 헤더 추가
            String secretKeyEncoded = Base64.getEncoder().encodeToString(TOSS_SECRET_KEY.getBytes(StandardCharsets.UTF_8));
            connection.setRequestProperty("Authorization", "Basic " + secretKeyEncoded);
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);
            
            // 요청 데이터 생성
            JSONObject requestData = new JSONObject();
            requestData.put("orderId", orderId);
            requestData.put("amount", Integer.parseInt(amount));
            
            // 요청 전송
            try (OutputStream writer = connection.getOutputStream()) {
                writer.write(requestData.toString().getBytes(StandardCharsets.UTF_8));
                writer.flush();
            }
            
            // 응답 처리
            int responseCode = connection.getResponseCode();
            
            if (responseCode >= 200 && responseCode < 300) {
                // 성공 응답 처리
                try (BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), StandardCharsets.UTF_8))) {
                    StringBuilder response = new StringBuilder();
                    String line;
                    while ((line = br.readLine()) != null) {
                        response.append(line);
                    }
                    
                    JSONParser parser = new JSONParser();
                    return (JSONObject) parser.parse(response.toString());
                }
            } else {
                // 에러 응답 처리
                try (BufferedReader br = new BufferedReader(new InputStreamReader(connection.getErrorStream(), StandardCharsets.UTF_8))) {
                    StringBuilder response = new StringBuilder();
                    String line;
                    while ((line = br.readLine()) != null) {
                        response.append(line);
                    }
                    
                    System.err.println("토스페이먼츠 API 에러 응답: " + response.toString());
                    
                    JSONParser parser = new JSONParser();
                    return (JSONObject) parser.parse(response.toString());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return null;
    }
}