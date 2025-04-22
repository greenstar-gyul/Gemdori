package com.gemdori.purchase;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

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

public class SuccessControl implements Control {
    
    private GemdoriShoppingCartService cartService;
    
    public SuccessControl() {
        this.cartService = new GemdoriShoppingCartServiceImpl();
    }
    
    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 세션에서 로그인 사용자 정보 가져오기
        HttpSession session = req.getSession();
        UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser");
        
        // 로그인 체크
        if (loginUser == null) {
            resp.sendRedirect("login.do?redirect=main.do");
            return;
        }
        
        String userCode = loginUser.getUserCode();
        
        try {
            // 먼저, 토스페이먼츠 API 연동 처리
            // 요청 파라미터 받기
            String orderId = req.getParameter("orderId");
            String paymentKey = req.getParameter("paymentKey");
            String amount = req.getParameter("amount");
            
            // API 호출 준비
            String secretKey = "test_sk_zXLkKEypNArWmo50nX3lmeaxYG5R:";
            Base64.Encoder encoder = Base64.getEncoder();
            byte[] encodedBytes = encoder.encode(secretKey.getBytes("UTF-8"));
            String authorizations = "Basic " + new String(encodedBytes, 0, encodedBytes.length);
            
            // URL 인코딩
            paymentKey = URLEncoder.encode(paymentKey, StandardCharsets.UTF_8);
            
            // API 연결 설정
            URL url = new URL("https://api.tosspayments.com/v/payments/confirm");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestProperty("Authorization", authorizations);
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);
            
            // 요청 데이터 설정
            JSONObject obj = new JSONObject();
            obj.put("paymentKey", paymentKey);
            obj.put("orderId", orderId);
            obj.put("amount", amount);
            
            // 요청 보내기
            OutputStream outputStream = connection.getOutputStream();
            outputStream.write(obj.toString().getBytes("UTF-8"));
            
            // 응답 처리
            int code = connection.getResponseCode();
            boolean isSuccess = code == 200;
            
            if (isSuccess) {
                // 결제 성공 시, 장바구니 아이템을 주문 테이블로 이동 (아직 주문 테이블은 구현되지 않았으므로 생략)
                // 그리고 장바구니 비우기
                boolean clearResult = cartService.clearCart(userCode);
                
                if (clearResult) {
                    System.out.println("결제 성공 및 장바구니 비우기 성공");
                } else {
                    System.out.println("결제는 성공했지만 장바구니 비우기 실패");
                }
            }
            
            // 결제 결과 정보 처리
            InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();
            Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
            JSONParser parser = new JSONParser();
            JSONObject jsonObject = (JSONObject) parser.parse(reader);
            responseStream.close();
            
            // 요청 결과 세팅
            req.setAttribute("isSuccess", isSuccess);
            req.setAttribute("jsonObject", jsonObject);
            
            // JSP로 포워드
            req.getRequestDispatcher("purchase/success.tiles").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("main.do?error=payment_error");
        }
    }
}