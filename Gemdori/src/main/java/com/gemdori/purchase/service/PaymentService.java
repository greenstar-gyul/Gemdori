package com.gemdori.purchase.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.gemdori.common.MybatisSessionFactory;
import com.gemdori.purchase.mapper.GemdoriShoppingCartMapper;
import com.gemdori.purchase.vo.GemdoriShoppingCartVO;

public class PaymentService {
    
    // 토스페이먼츠 시크릿 키 (테스트용)
    private static final String TOSS_SECRET_KEY = "test_sk_D5GePWvyJnrK0W0k6q8gLzN97Eoq:";
    private static final String TOSS_API_URL = "https://api.tosspayments.com/v1/payments/";
    
    private SqlSessionFactory sqlSessionFactory;
    
    public PaymentService() {
        try {
            this.sqlSessionFactory = MybatisSessionFactory.getInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // 장바구니 아이템 목록 조회
    public List<GemdoriShoppingCartVO> getCartItems(String userCode) {
        List<GemdoriShoppingCartVO> cartItems = null;
        SqlSession sqlSession = null;
        
        try {
            sqlSession = sqlSessionFactory.openSession();
            GemdoriShoppingCartMapper cartMapper = sqlSession.getMapper(GemdoriShoppingCartMapper.class);
            cartItems = cartMapper.SelectCartItemsByUser(userCode);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
        
        return cartItems;
    }
    
 // 장바구니 총 금액, 할인액, 최종 결제액 계산
    public Map<String, Object> calculateCartTotal(String userCode) {
        Map<String, Object> total = new HashMap<>();
        SqlSession sqlSession = null;

        try {
            sqlSession = sqlSessionFactory.openSession();
            GemdoriShoppingCartMapper cartMapper = sqlSession.getMapper(GemdoriShoppingCartMapper.class);
            total = cartMapper.selectCartTotals(userCode);
            
            // 결과가 null인 경우를 대비해 기본값 설정
            if (total == null) {
                total = new HashMap<>();
                total.put("TOTAL_ORIGINAL_PRICE", 0);
                total.put("TOTAL_DISCOUNT", 0);
                total.put("TOTAL_PAYMENT", 0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 시 기본값 설정
            total = new HashMap<>();
            total.put("TOTAL_ORIGINAL_PRICE", 0);
            total.put("TOTAL_DISCOUNT", 0);
            total.put("TOTAL_PAYMENT", 0);
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }

        return total;
    }
    
    // 장바구니 할인 금액 계산
    public int calculateCartDiscount(String userCode) {
        int discount = 0;
        SqlSession sqlSession = null;
        
        try {
            sqlSession = sqlSessionFactory.openSession();
            GemdoriShoppingCartMapper cartMapper = sqlSession.getMapper(GemdoriShoppingCartMapper.class);
            discount = cartMapper.selectCartDiscountAmount(userCode);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
        
        return discount;
    }
    
    // 토스페이먼츠 결제 승인 API 호출
    public JSONObject confirmPayment(String paymentKey, String orderId, String amount) {
        try {
            // API URL 설정
            URL url = new URL(TOSS_API_URL + paymentKey);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            
            // 인증 헤더 추가
            String secretKeyEncoded = Base64.getEncoder().encodeToString((TOSS_SECRET_KEY).getBytes(StandardCharsets.UTF_8));
            connection.setRequestProperty("Authorization", "Basic " + secretKeyEncoded);
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);
            
            // 요청 데이터 생성
            JSONObject requestData = new JSONObject();
            requestData.put("orderId", orderId);
            requestData.put("amount", Integer.parseInt(amount));
            
            // 요청 전송
            try (OutputStreamWriter writer = new OutputStreamWriter(connection.getOutputStream(), StandardCharsets.UTF_8)) {
                writer.write(requestData.toString());
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
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // 결제 정보 저장 (구매 내역 테이블에 저장)
    public boolean saveGamePurchaseHistory(String userCode, JSONObject paymentResult, List<GemdoriShoppingCartVO> cartItems) {
        SqlSession sqlSession = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            sqlSession = sqlSessionFactory.openSession();
            conn = sqlSession.getConnection();
            
            boolean allSuccess = true;
            
            // 각 게임별로 구매 내역 저장
            for (GemdoriShoppingCartVO item : cartItems) {
                String purchaseCode = generatePurchaseCode();
                int price = item.getGamePrice();
                int discountRate = 0;
                
                // 할인이 적용된 경우 할인율 계산
                if (item.getGameSalePrice() != null && item.getGameSalePrice() > 0 && item.getGameSalePrice() < price) {
                    int discountAmount = price - item.getGameSalePrice();
                    discountRate = (int) Math.round(((double) discountAmount / price) * 100);
                    price = item.getGameSalePrice(); // 할인가로 설정
                }
                
                String paymentMethod = (String) paymentResult.get("method");
                if (paymentMethod == null) paymentMethod = "card"; // 기본값 설정
                
                String sql = "INSERT INTO gemdori_purchase_history_table "
                        + "(purchase_code, user_code, game_code, recipient_code, purchase_date, "
                        + "price, discount_rate, payment_method, purchase_status) "
                        + "VALUES (?, ?, ?, NULL, SYSDATE, ?, ?, ?, 1)";
                
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, purchaseCode);
                pstmt.setString(2, userCode);
                pstmt.setString(3, item.getGameCode());
                pstmt.setInt(4, price);
                pstmt.setInt(5, discountRate);
                pstmt.setString(6, paymentMethod);
                
                int result = pstmt.executeUpdate();
                if (result <= 0) {
                    allSuccess = false;
                }
                
                pstmt.close();
            }
            
            // 성공 시 커밋
            if (allSuccess) {
                sqlSession.commit();
            } else {
                sqlSession.rollback();
            }
            
            return allSuccess;
            
        } catch (Exception e) {
            e.printStackTrace();
            if (sqlSession != null) {
                sqlSession.rollback();
            }
            return false;
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (sqlSession != null) sqlSession.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    // 구매 코드 생성 (P + 7자리 숫자)
    private String generatePurchaseCode() {
        SqlSession sqlSession = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            sqlSession = sqlSessionFactory.openSession();
            conn = sqlSession.getConnection();
            
            // 현재 가장 큰 구매코드 번호 조회
            String sql = "SELECT MAX(SUBSTR(purchase_code, 2)) AS max_num FROM gemdori_purchase_history_table";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            int maxNum = 0;
            if (rs.next()) {
                String maxStr = rs.getString("max_num");
                if (maxStr != null && !maxStr.isEmpty()) {
                    maxNum = Integer.parseInt(maxStr);
                }
            }
            
            // 다음 번호 생성
            int nextNum = maxNum + 1;
            return "P" + String.format("%07d", nextNum);
            
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 발생 시 랜덤 코드 생성
            return "P" + String.format("%07d", (int)(Math.random() * 10000000));
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (sqlSession != null) sqlSession.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    // 장바구니 비우기
    public boolean clearUserCart(String userCode) {
        SqlSession sqlSession = null;
        
        try {
            sqlSession = sqlSessionFactory.openSession();
            GemdoriShoppingCartMapper cartMapper = sqlSession.getMapper(GemdoriShoppingCartMapper.class);
            
            int result = cartMapper.clearCartByUser(userCode);
            
            if (result > 0) {
                sqlSession.commit();
                return true;
            } else {
                sqlSession.rollback();
                return false;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            if (sqlSession != null) {
                sqlSession.rollback();
            }
            return false;
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }
}