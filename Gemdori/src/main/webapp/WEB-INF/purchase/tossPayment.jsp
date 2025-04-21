<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%-- 금액 표시용 --%>
<%@ page import="java.util.UUID" %> <%-- 고유 ID 생성용 --%>

<%
    // 테스트용 데이터 설정 (원래는 CheckOutControl 등에서 동적으로 받아와야 함)
    int testAmount = 1000; // 테스트 결제 금액 (100원 이상)
    String testOrderId = "test_" + UUID.randomUUID().toString().substring(0, 18); // 테스트용 고유 주문 ID 생성
    String testOrderName = "테스트 상품";
    String testCustomerName = "테스트 고객";

    // 현재 페이지 기준 success/fail URL 생성 (상대 경로)
    // 실제로는 컨트롤러에서 절대 경로 URL을 생성해야 함
    String successUrl = "paymentSuccess.jsp";
    String failUrl = "paymentFail.jsp";

    String clientKey = "test_ck_DnyRpQWGrNla9B9klynl3Kwv1M9E"; // 테스트 클라이언트 키
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>토스페이먼츠 테스트</title>
    <script src="https://js.tosspayments.com/v2/standard"></script>
    <style>
        body { font-family: sans-serif; padding: 20px; }
        button { padding: 10px 20px; font-size: 16px; cursor: pointer; }
    </style>
</head>
<body>

    <h1>토스페이먼츠 기본 테스트</h1>

    <p>결제할 금액: <fmt:formatNumber value="<%= testAmount %>" type="currency" currencySymbol="₩ "/></p>
    <p>주문 번호: <%= testOrderId %></p>
    <p>주문 이름: <%= testOrderName %></p>

    <button id="payment-button"><fmt:formatNumber value="<%= testAmount %>" type="number" groupingUsed="false"/>원 결제 테스트</button>

    <script>
        var clientKey = '<%= clientKey %>';
        var tossPayments = TossPayments(clientKey); // 토스페이먼츠 객체 초기화

        var button = document.getElementById('payment-button'); // 버튼 요소 가져오기

        // 버튼 클릭 이벤트 리스너 추가
        button.addEventListener('click', function () {
            console.log("결제 요청 시작");

            // 하드코딩된 테스트 데이터로 결제 요청
            tossPayments.requestPayment('카드', { // '카드' 외 다른 결제수단 가능
                amount: <%= testAmount %>,             // 결제 금액
                orderId: '<%= testOrderId %>',         // 고유 주문번호
                orderName: '<%= testOrderName %>',     // 주문명
                customerName: '<%= testCustomerName %>', // 고객명
                successUrl: '<%= successUrl %>',       // 성공 시 이동할 URL (현재 페이지 기준 상대 경로)
                failUrl: '<%= failUrl %>',             // 실패 시 이동할 URL (현재 페이지 기준 상대 경로)
                // flowMode: 'DIRECT', // 필요 시 사용
                // ... 기타 옵션 ...
            })
            .then(function(data) {
                // 가상계좌 등 일부 결제수단은 성공 콜백이 여기서 호출될 수 있음
                // 일반적으로 successUrl로 리다이렉트됨
                console.log('결제 성공(then):', data);
                // window.location.href = '<%= successUrl %>?paymentKey=' + data.paymentKey + '&orderId=' + data.orderId + '&amount=' + data.amount;
             })
            .catch(function (error) {
                // 결제창이 닫히거나 오류 발생 시
                console.error('결제 요청 실패/오류:', error);
                // 실패 페이지로 리다이렉트 (선택 사항)
                // window.location.href = '<%= failUrl %>?code=' + error.code + '&message=' + encodeURIComponent(error.message) + '&orderId=<%= testOrderId %>';
                alert('결제 오류: ' + error.message);
            });
        });
    </script>

</body>
</html>