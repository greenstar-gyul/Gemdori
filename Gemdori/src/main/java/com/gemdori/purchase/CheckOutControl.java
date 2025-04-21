package com.gemdori.purchase;

import java.io.IOException;
import java.util.List;
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
    private final String TOSS_CLIENT_KEY = "test_ck_DnyRpQWGrNla9B9klynl3Kwv1M9E"; // 실제 발급받은 테스트 클라이언트 키 사용

    public CheckOutControl() {
        this.cartService = new GemdoriShoppingCartServiceImpl();
    }

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 세션에서 로그인 사용자 정보 가져오기
        HttpSession session = req.getSession();
        UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser");

        // 로그인 체크: 로그인되지 않았으면 로그인 페이지로 리다이렉트
        if (loginUser == null) {
            // 로그인 후 원래 페이지(결제 페이지)로 돌아올 수 있도록 redirect 파라미터 추가
            resp.sendRedirect(req.getContextPath() + "/login.do?redirect=checkout.do");
            return;
        }

        try {
            String userCode = loginUser.getUserCode();

            // 사용자의 장바구니 아이템 조회 (GemdoriShoppingCartVO 리스트 반환 가정)
            List<GemdoriShoppingCartVO> cartItems = cartService.getCartItemsByUser(userCode);

            // 장바구니가 비어있으면 장바구니 페이지로 리다이렉트
            if (cartItems == null || cartItems.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/cartPage.do?message=empty_cart");
                return;
            }

            // --- 결제 페이지 표시에 필요한 데이터 계산 ---
            // 서비스 계층에서 장바구니 아이템 기반으로 계산된 값을 가져옴
            int totalAmount = cartService.getCartTotalAmount(userCode); // 할인 적용 전 총 금액 (예: 모든 gamePrice의 합)
            int discountAmount = cartService.getCartDiscountAmount(userCode); // 총 할인액 (예: (gamePrice - gameSalePrice)의 합)
            int finalAmount = totalAmount - discountAmount; // 실제 결제할 최종 금액 (모든 gameSalePrice의 합과 같아야 함)

            // 음수 방지
            if (finalAmount < 0) {
                finalAmount = 0;
            }
            // 최소 결제 금액 처리 (토스페이먼츠는 보통 100원 이상)
            if (finalAmount < 100 && finalAmount > 0) {
                // 100원 미만 결제 불가 로직 (예외 발생 또는 메시지 전달)
                // 여기서는 일단 진행하지만, 실제로는 정책에 따라 처리 필요
                System.out.println("경고: 최종 결제 금액이 100원 미만입니다 (" + finalAmount + "원)");
            }

            // JSP에서 사용할 수 있도록 request attribute에 저장
            req.setAttribute("userInfo", loginUser); // 사용자 정보
            req.setAttribute("cartItems", cartItems); // 장바구니 게임 목록 (GemdoriShoppingCartVO 리스트)
            req.setAttribute("totalAmount", totalAmount); // 할인 전 총액
            req.setAttribute("discountAmount", discountAmount); // 할인 금액
            req.setAttribute("finalAmount", finalAmount); // 최종 결제 금액

            // --- 토스페이먼츠 연동에 필요한 데이터 생성 ---

            // 1. 고유 주문번호 생성 (매 결제 요청마다 달라야 함, 예: UUID 사용)
            String orderId = UUID.randomUUID().toString();

            // 2. 주문명 생성 (GemdoriShoppingCartVO의 gameTitle 사용, 예: 첫 게임 제목 + " 외 X건")
            String orderName = "젬도리 게임 구매"; // 기본 주문명
            if (!cartItems.isEmpty()) {
                GemdoriShoppingCartVO firstItem = cartItems.get(0);
                orderName = firstItem.getGameTitle(); // 첫 번째 게임의 제목 사용
                // 에디션 이름이 있다면 추가 (선택 사항)
                if (firstItem.getEditionName() != null && !firstItem.getEditionName().isEmpty()) {
                    orderName += " (" + firstItem.getEditionName() + ")";
                }
                // 상품이 여러 개일 경우 "외 N건" 추가
                if (cartItems.size() > 1) {
                    orderName += " 외 " + (cartItems.size() - 1) + "건";
                }
            }
            // 주문명 길이 제한 확인 (토스페이먼츠는 최대 100자)
            if (orderName.length() > 100) {
                orderName = orderName.substring(0, 100);
            }


            // 3. 고객명 가져오기
            String customerName = loginUser.getUserName(); // UserFullVO에 getName() 메소드가 있다고 가정

            // 4. 결제 성공/실패 시 돌아올 URL 정의 (절대 경로로 생성)
            String scheme = req.getScheme(); // http 또는 https
            String serverName = req.getServerName(); // localhost 또는 실제 도메인
            int serverPort = req.getServerPort(); // 8080, 80, 443 등
            String contextPath = req.getContextPath(); // 웹 애플리케이션 경로 (예: /gemdori)

            // 기본 URL 생성 (http/80, https/443 포트인 경우 생략)
             String baseUrl = scheme + "://" + serverName;
             if (!((scheme.equals("http") && serverPort == 80) || (scheme.equals("https") && serverPort == 443))) {
                 baseUrl += ":" + serverPort;
             }
             baseUrl += contextPath;


            String successUrl = baseUrl + "/paymentSuccess.do"; // 결제 성공 시 이동할 컨트롤러 URL
            String failUrl = baseUrl + "/paymentFail.do";     // 결제 실패 시 이동할 컨트롤러 URL

            // 5. 토스페이먼츠 연동에 필요한 값들을 request attribute에 저장
            req.setAttribute("tossClientKey", TOSS_CLIENT_KEY);       // 토스페이먼츠 클라이언트 키
            req.setAttribute("paymentAmount", finalAmount);          // 최종 결제 금액 (finalAmount 사용)
            req.setAttribute("paymentOrderId", orderId);             // 고유 주문번호
            req.setAttribute("paymentOrderName", orderName);         // 주문명
            req.setAttribute("paymentCustomerName", customerName);   // 고객명
            req.setAttribute("paymentSuccessUrl", successUrl);       // 성공 콜백 URL
            req.setAttribute("paymentFailUrl", failUrl);             // 실패 콜백 URL


            // --- 결제 페이지(JSP)로 포워딩 ---
            // 실제 JSP 파일 경로로 수정해주세요. (예: /WEB-INF/views/purchase/checkOut.jsp)
            req.getRequestDispatcher("purchase/checkOut.tiles").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace(); // 콘솔에 에러 로그 출력
            // 오류 발생 시 사용자에게 알리고 장바구니 페이지 등으로 리다이렉트
            resp.sendRedirect(req.getContextPath() + "/cartPage.do?error=checkout_error");
        }
    }
}