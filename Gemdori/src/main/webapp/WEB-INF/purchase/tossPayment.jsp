<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제하기 - 젬도리</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <!-- 토스페이먼츠 SDK 추가 -->
    <script src="https://js.tosspayments.com/v2/standard"></script>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            color: #ffffff;
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 1170px;
            margin: 0 auto;
            padding: 0 15px;
        }
        
        /* 전체 섹션에 패딩 추가해서 높이 늘리기 */
        .payment-section {
            padding: 80px 0; /* 위아래 패딩 증가 */
            min-height: 350px; /* 최소 높이 설정 */
        }
        
        .payment-box {
            background-color: #1d1e39;
            border-radius: 10px;
            padding: 60px; /* 패딩 키워서 내부 공간 확보 */
            margin-bottom: 50px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            min-height: 450px; /* 최소 높이 설정 */
            display: flex;
            flex-direction: column;
        }
        
        .title {
            text-align: left;
            margin-bottom: 40px; /* 간격 늘림 */
            color: #fff;
            font-size: 28px;
            font-weight: 700;
            position: relative;
            padding-bottom: 15px;
        }
        
        .title:after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 0;
            width: 70px;
            height: 3px;
            background-color: #e53637;
        }
        
        .order-info {
            margin-bottom: 50px; /* 간격 늘림 */
        }
        
        .order-info span {
            color: white;
            font-size: 16px; /* 글자 크기 키움 */
        }
        
        .order-info p.highlight {
            font-weight: bold;
            color: #e53637;
        }
        
        .order-info p {
            margin: 15px 0; /* 간격 늘림 */
            display: flex;
            justify-content: space-between;
        }
        
        .payment-methods-container {
            flex-grow: 1; /* 남은 공간 채우기 */
            display: flex;
            flex-direction: column;
        }
        
        .payment-methods {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px; /* 간격 늘림 */
            margin-bottom: 40px;
        }
        
        .button2 {
            background-color: #ffffff;
            border: 2px solid transparent;
            border-radius: 10px; /* 둥글게 */
            padding: 20px 25px; /* 패딩 키워서 버튼 크기 확대 */
            cursor: pointer;
            transition: all 0.3s;
            min-width: 140px; /* 너비 키움 */
            min-height: 100px; /* 높이 키움 */
            text-align: center;
            color: #000000;
            font-weight: 600;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        
        .button2 i {
            font-size: 24px; /* 아이콘 크기 키움 */
            margin-bottom: 10px;
        }
        
        .button2:hover {
            background-color: rgb(229, 239, 255);
            transform: translateY(-5px); /* 호버 시 살짝 위로 올라가는 효과 */
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn-payment {
            background-color: #e53637;
            border: none;
            color: white;
            padding: 18px 30px; /* 패딩 키워서 버튼 크게 */
            font-size: 18px; /* 폰트 사이즈 키움 */
            font-weight: 700;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s;
            margin-top: auto; /* 하단에 고정 */
        }
        
        .btn-payment:hover {
            background-color: #c52e2e;
        }
        
        .btn-payment:disabled {
            background-color: #666;
            cursor: not-allowed;
        }
        
        .error-message {
            color: #e53637;
            text-align: center;
            margin-bottom: 30px; /* 간격 늘림 */
            min-height: 24px; /* 최소 높이 설정 */
        }
        
        .order-summary {
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding-top: 30px;
            margin-top: 30px;
        }
        
        .breadcrumb-option {
            padding: 35px 0;
        }
        
        .breadcrumb__links {
            display: flex;
            align-items: center;
        }
        
        .breadcrumb__links a {
            color: #b7b7b7;
            margin-right: 18px;
            position: relative;
            font-size: 15px;
            text-decoration: none;
        }
        
        .breadcrumb__links a:after {
            content: "/";
            position: absolute;
            right: -12px;
            top: 0;
            color: #b7b7b7;
        }
        
        .breadcrumb__links span {
            color: #ffffff;
            font-size: 15px;
        }
        
        .breadcrumb__links a i {
            margin-right: 5px;
        }
        
        /* 반응형 스타일 */
        @media (max-width: 768px) {
            .payment-box {
                padding: 30px;
            }
            
            .payment-methods {
                gap: 10px;
            }
            
            .button2 {
                min-width: 120px;
                min-height: 90px;
                padding: 15px;
            }
        }
    </style>
</head>
<body>
    <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="./index.do"><i class="fa fa-home"></i> 홈</a>
                        <a href="./cartPage.do">장바구니</a>
                        <a href="./checkout.do">결제하기</a>
                        <span>결제 수단 선택</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Payment Section Begin -->
    <section class="payment-section">
        <div class="container">
            <div class="payment-box">
                <h2 class="title">결제 수단 선택</h2>
                
                <div class="order-info">
                    <p>
                        <span>주문 상품:</span>
                        <span>${paymentOrderName}</span>
                    </p>
                    <p>
                        <span>주문 번호:</span>
                        <span>${paymentOrderId}</span>
                    </p>
                    <p class="highlight">
                        <span style="color: #e53637;">결제 금액:</span>
                        <span><fmt:formatNumber value="${paymentAmount}" pattern="#,###" />원</span>
                    </p>
                </div>
                
                <div class="payment-methods-container">
                    <div id="payment-method" class="payment-methods">
                        <button id="CARD" class="button2" onclick="selectPaymentMethod('CARD')">
                            <i class="fas fa-credit-card"></i>
                            간편결제&카드
                        </button>
                        <button id="TRANSFER" class="button2" onclick="selectPaymentMethod('TRANSFER')">
                            <i class="fas fa-university"></i>
                            계좌이체
                        </button>
                        <button id="VIRTUAL_ACCOUNT" class="button2" onclick="selectPaymentMethod('VIRTUAL_ACCOUNT')">
                            <i class="fas fa-wallet"></i>
                            가상계좌
                        </button>
                        <button id="MOBILE_PHONE" class="button2" onclick="selectPaymentMethod('MOBILE_PHONE')">
                            <i class="fas fa-mobile-alt"></i>
                            휴대폰
                        </button>
                    </div>
                    
                    <div id="error-message" class="error-message"></div>
                </div>
                
                <button id="payment-button" class="btn-payment" disabled onclick="requestPayment()">
                    결제 수단을 선택해주세요
                </button>
            </div>
        </div>
    </section>
    <!-- Payment Section End -->

    <script>
        let selectedMethod = null;
        const paymentButton = document.getElementById('payment-button');
        const errorMessageEl = document.getElementById('error-message');
        
        // 토스페이먼츠 초기화
        const clientKey = "${tossClientKey}";
        const customerKey = "${customerKey}"; // 사용자 고유 ID
        
        // 초기화 시도
        let tossPayments = null;
        let payment = null;
        
        try {
            tossPayments = TossPayments(clientKey);
            payment = tossPayments.payment({ customerKey });
            console.log("토스페이먼츠 SDK 초기화 성공");
        } catch (e) {
            console.error("토스페이먼츠 초기화 오류:", e);
            errorMessageEl.textContent = '결제 시스템 초기화에 실패했습니다. 관리자에게 문의해주세요.';
        }
        
        // 결제 수단 선택
        function selectPaymentMethod(method) {
            // 이전 선택 요소 스타일 초기화
            if (selectedMethod) {
                document.getElementById(selectedMethod).style.backgroundColor = "#ffffff";
                document.getElementById(selectedMethod).style.transform = "translateY(0)";
            }
            
            // 새 선택 요소 스타일 변경
            selectedMethod = method;
            document.getElementById(selectedMethod).style.backgroundColor = "rgb(229, 239, 255)";
            document.getElementById(selectedMethod).style.transform = "translateY(-5px)";
            
            // 버튼 활성화 및 텍스트 변경
            paymentButton.disabled = false;
            
            if (selectedMethod === 'TOSSPAY') {
                paymentButton.innerHTML = '<i class="fas fa-won-sign"></i> 토스페이로 결제하기';
            } else {
                paymentButton.innerHTML = '<i class="fas fa-credit-card"></i> 결제하기';
            }
        }
        
        // 결제 요청
        async function requestPayment() {
            if (!selectedMethod || !payment) return;
            
            paymentButton.disabled = true;
            paymentButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 결제 요청 중...';
            errorMessageEl.textContent = '';
            
            try {
                // 결제 요청 공통 파라미터
                const paymentParams = {
                    method: selectedMethod,
                    amount: {
                        currency: "KRW",
                        value: ${paymentAmount}
                    },
                    orderId: "${paymentOrderId}",
                    orderName: "${paymentOrderName}",
                    customerName: "${paymentCustomerName}",
                    successUrl: "${paymentSuccessUrl}",
                    failUrl: "${paymentFailUrl}"
                };
                
                // 결제 요청 수행
                await payment.requestPayment(paymentParams);
                
            } catch (error) {
                console.error('결제 요청 실패:', error);
                errorMessageEl.textContent = `결제 요청 중 오류가 발생했습니다: ${error.message}`;
                paymentButton.disabled = false;
                paymentButton.textContent = '다시 시도하기';
            }
        }
        
        // 0원 주문 처리 기능 (무료 게임일 경우)
        function handleFreeOrder() {
            window.location.href = "${paymentSuccessUrl}?paymentKey=FREE_ORDER&orderId=${paymentOrderId}&amount=0";
        }
        
        // 결제 금액이 0원이면 무료 처리 버튼으로 변경
        <c:if test="${paymentAmount <= 0}">
            paymentButton.disabled = false;
            paymentButton.innerHTML = '<i class="fas fa-gift"></i> 게임 라이브러리에 추가하기';
            paymentButton.onclick = handleFreeOrder;
            
            // 결제 수단 선택 부분 숨기기
            document.getElementById('payment-method').style.display = 'none';
            document.querySelector('.title').textContent = '무료 게임 추가';
        </c:if>
    </script>
</body>
</html>