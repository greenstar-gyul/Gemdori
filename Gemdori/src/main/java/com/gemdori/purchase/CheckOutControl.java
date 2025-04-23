package com.gemdori.purchase;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID; // 고유한 주문 ID 생성을 위해 UUID 임포트

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;
import com.gemdori.member.vo.UserFullVO;
import com.gemdori.purchase.service.GemdoriShoppingCartService;
import com.gemdori.purchase.service.GemdoriShoppingCartServiceImpl;
import com.gemdori.purchase.vo.GemdoriShoppingCartVO; // 제공된 VO 임포트

public class CheckOutControl implements Control {

    private GemdoriShoppingCartService cartService;
    // 중요: 클라이언트 키는 설정 파일이나 환경 변수 등 안전한 곳에서 로드하는 것이 좋습니다.
    private final String TOSS_CLIENT_KEY = "test_ck_DnyRpQWGrNla9B9klynl3Kwv1M9E:"; // 실제 발급받은 테스트 클라이언트 키 사용

    public CheckOutControl() {
        this.cartService = new GemdoriShoppingCartServiceImpl();
    }

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser");

        if (loginUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login.do?redirect=checkout.do");
            return;
        }

        try {
            String userCode = loginUser.getUserCode();
            
            // 직접 구매 파라미터 확인
            String gameCode = req.getParameter("gameCode");
            String directBuy = req.getParameter("directBuy");
            
            List<GemdoriShoppingCartVO> cartItems;
            Map<String, Object> cartSummary;
            
         // 직접 구매인 경우
            if ("true".equals(directBuy) && gameCode != null && !gameCode.isEmpty()) {
                // 게임 정보 조회해서 카트아이템 리스트 생성
                cartItems = cartService.getGameDetailForDirectBuy(gameCode);
                
                // 사용자 코드 설정
                if (cartItems != null && !cartItems.isEmpty()) {
                    for (GemdoriShoppingCartVO item : cartItems) {
                        item.setUserCode(userCode);
                    }
                    
                    // 직접 가격 계산 로직
                    GemdoriShoppingCartVO item = cartItems.get(0);
                    int totalAmount = item.getGamePrice();
                    int finalAmount = (item.getGameSalePrice() > 0) ? item.getGameSalePrice() : item.getGamePrice();
                    int discountAmount = totalAmount - finalAmount;
                    
                    // 요약 정보 설정
                    Map<String, Object> directBuySummary = new HashMap<>();
                    directBuySummary.put("TOTAL_ORIGINAL_PRICE", totalAmount);
                    directBuySummary.put("TOTAL_DISCOUNT", discountAmount);
                    directBuySummary.put("TOTAL_PAYMENT", finalAmount);
                    
                    cartSummary = directBuySummary;
                } else {
                    // 게임 정보가 없으면 오류 처리
                    resp.sendRedirect(req.getContextPath() + "/gamePage.do?error=game_not_found");
                    return;
                }
            } else {
                // 기존 장바구니에서 가져오기
                cartItems = cartService.getCartItemsByUser(userCode);
                
                if (cartItems == null || cartItems.isEmpty()) {
                    resp.sendRedirect(req.getContextPath() + "/cartPage.do?message=empty_cart");
                    return;
                }
                
                // 기존 장바구니 가격 계산
                cartSummary = cartService.getCartTotalAmount(userCode);
            }

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

            // --- JSP에서 사용할 기본 정보 설정 ---
            req.setAttribute("userInfo", loginUser);
            req.setAttribute("cartItems", cartItems);
            req.setAttribute("totalAmount", totalAmount);
            req.setAttribute("discountAmount", discountAmount);
            req.setAttribute("finalAmount", finalAmount); // 최종 결제 금액 (위젯에서도 사용)

            // --- 토스페이먼츠 연동 데이터 ---
            String orderId = UUID.randomUUID().toString();
            String orderName = "젬도리 게임 구매"; // 기본 주문명 설정 (필요시 이전 로직 사용)
            if (!cartItems.isEmpty()) {
                 GemdoriShoppingCartVO firstItem = cartItems.get(0);
                 orderName = firstItem.getGameTitle();
                 if (firstItem.getEditionName() != null && !firstItem.getEditionName().isEmpty()) {
                     orderName += " (" + firstItem.getEditionName() + ")";
                 }
                 if (cartItems.size() > 1) {
                     orderName += " 외 " + (cartItems.size() - 1) + "건";
                 }
                 if (orderName.length() > 100) {
                    orderName = orderName.substring(0, 100);
                 }
            }
            String customerName = loginUser.getUserName();

            // --- 콜백 URL 생성 ---
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

            // --- request attribute 설정 (결제 위젯에 필요한 값 포함) ---
            req.setAttribute("tossClientKey", TOSS_CLIENT_KEY);       // 클라이언트 키
            req.setAttribute("customerKey", userCode);                // [추가됨] 사용자 고유 ID (위젯용)
            req.setAttribute("paymentAmount", finalAmount);           // 결제 금액
            req.setAttribute("paymentOrderId", orderId);              // 주문 번호
            req.setAttribute("paymentOrderName", orderName);          // 주문명
            req.setAttribute("paymentCustomerName", customerName);    // 고객명
            req.setAttribute("paymentSuccessUrl", successUrl);        // 성공 콜백 URL
            req.setAttribute("paymentFailUrl", failUrl);              // 실패 콜백 URL
            // Optional: 이메일이나 전화번호 정보가 있다면 위젯에 전달 가능
            // req.setAttribute("paymentCustomerEmail", loginUser.getEmail());
            // req.setAttribute("paymentCustomerMobilePhone", loginUser.getPhoneNumber());


            // --- 결제 페이지(JSP/Tiles)로 포워딩 ---
            req.getRequestDispatcher("purchase/checkOut.tiles").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/cartPage.do?error=checkout_error");
        }
    }
}