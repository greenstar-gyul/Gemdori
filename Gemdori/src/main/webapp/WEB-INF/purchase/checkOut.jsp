<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제하기 - 젬도리</title>
    <!-- 폰트어썸 아이콘 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- 노토 산스 KR 폰트 추가 -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
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
        
        .checkout-section {
            padding: 50px 0;
        }
        
        .checkout-container {
            background-color: #1d1e39;
            border-radius: 10px;
            padding: 40px;
            margin-bottom: 50px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.5s ease-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .section-title {
            color: #fff;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 30px;
            position: relative;
            padding-bottom: 15px;
        }
        
        .section-title:after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 0;
            width: 70px;
            height: 3px;
            background-color: #e53637;
        }
        
        .game-list {
            list-style: none;
            padding: 0;
            margin: 0 0 40px 0;
        }
        
        .game-item {
            display: flex;
            align-items: center;
            padding: 20px;
            margin-bottom: 15px;
            background-color: rgba(255, 255, 255, 0.05);
            border-radius: 8px;
            transition: transform 0.2s ease;
        }
        
        .game-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .game-image {
            width: 80px;
            height: 80px;
            margin-right: 20px;
            border-radius: 5px;
            overflow: hidden;
            flex-shrink: 0;
        }
        
        .game-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .game-details {
            flex: 1;
        }
        
        .game-title {
            font-size: 18px;
            font-weight: 600;
            margin: 0 0 5px 0;
            color: #fff;
        }
        
        .game-edition {
            font-size: 14px;
            color: #b7b7b7;
            margin: 0 0 10px 0;
        }
        
        .game-price {
            margin: 0;
        }
        
        .original-price {
            text-decoration: line-through;
            color: #b7b7b7;
            margin-right: 10px;
            font-size: 14px;
        }
        
        .sale-price, .price {
            color: #e53637;
            font-weight: 600;
            font-size: 16px;
        }
        
        .summary-section {
            background-color: rgba(255, 255, 255, 0.05);
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 30px;
        }
        
        .summary-title {
            color: #fff;
            font-size: 20px;
            font-weight: 600;
            margin: 0 0 20px 0;
            padding-bottom: 10px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            color: #b7b7b7;
        }
        
        .summary-total {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            font-size: 18px;
            font-weight: 600;
            color: #fff;
        }
        
        .payment-button {
            display: block;
            width: 100%;
            background-color: #e53637;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 15px;
            font-size: 18px;
            font-weight: 700;
            cursor: pointer;
            transition: background-color 0.2s;
            margin-bottom: 20px;
        }
        
        .payment-button:hover {
            background-color: #d82a2b;
        }
        
        .payment-button:disabled {
            background-color: #555;
            cursor: not-allowed;
        }
        
        .payment-methods {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 15px;
            padding: 15px 0;
        }
        
        .payment-methods i {
            font-size: 30px;
            color: #b7b7b7;
        }
        
        /* 반응형 */
        @media (max-width: 768px) {
            .checkout-container {
                padding: 25px;
            }
            
            .game-item {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .game-image {
                width: 100%;
                height: 120px;
                margin-right: 0;
                margin-bottom: 15px;
            }
            
            .game-details {
                width: 100%;
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
                        <span>결제하기</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Checkout Section Begin -->
    <section class="checkout-section">
        <div class="container">
            <div class="checkout-container">
                <h2 class="section-title">결제 상품 정보</h2>

                <!-- 상품 목록 표시 -->
                <ul class="game-list">
                    <c:forEach var="item" items="${cartItems}">
                        <li class="game-item">
                            <div class="game-image">
                                <c:choose>
                                    <c:when test="${not empty item.gameMainImage}">
                                        <img src="${item.gameMainImage}" alt="${item.gameTitle}">
                                    </c:when>
                                    <c:otherwise>
                                        <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;background:#2a2a4a;">
                                            <i class="fas fa-gamepad" style="font-size:24px;color:#b7b7b7;"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="game-details">
                                <h3 class="game-title">${item.gameTitle}</h3>
                                <c:if test="${not empty item.editionName}">
                                    <p class="game-edition">${item.editionName}</p>
                                </c:if>
                                <p class="game-price">
                                    <c:choose>
                                        <c:when test="${item.gameSalePrice > 0 && item.gameSalePrice < item.gamePrice}">
                                            <span class="original-price"><fmt:formatNumber value="${item.gamePrice}" pattern="#,###" />원</span>
                                            <span class="sale-price"><fmt:formatNumber value="${item.gameSalePrice}" pattern="#,###" />원</span>
                                            <span style="color:#3fd13f;font-size:14px;margin-left:10px;">
                                                <c:set var="discountRate" value="${100 - ((item.gameSalePrice / item.gamePrice) * 100)}" />
                                                <fmt:formatNumber value="${discountRate}" pattern="#,##0" />% 할인
                                            </span>
                                        </c:when>
                                        <c:when test="${item.gamePrice > 0}">
                                            <span class="price"><fmt:formatNumber value="${item.gamePrice}" pattern="#,###" />원</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="price" style="color:#3fd13f;">무료</span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </li>
                    </c:forEach>
                </ul>

                <!-- 결제 요약 -->
                <div class="summary-section">
                    <h3 class="summary-title">결제 요약</h3>
                    <div class="summary-row">
                        <span>상품 금액</span>
                        <span><fmt:formatNumber value="${totalAmount}" pattern="###,###" />원</span>
                    </div>
                    <div class="summary-row">
                        <span>할인</span>
                        <span>- <fmt:formatNumber value="${discountAmount}" pattern="###,###" />원</span>
                    </div>
                    <div class="summary-total">
                        <span>총 결제금액</span>
                        <span style="color: #e53637"><fmt:formatNumber value="${finalAmount}" pattern="###,###" />원</span>
                    </div>
                </div>

                <!-- 오류 메시지 표시 영역 -->
                <div id="payment-error" style="min-height: 20px; color: #e53637; text-align: center; margin-bottom: 20px;"></div>

                <!-- 결제 버튼 -->
                <button id="payment-button" class="payment-button" <c:if test="${finalAmount < 100 and finalAmount > 0}">disabled</c:if>>
                    <c:choose>
                        <c:when test="${finalAmount <= 0}">
                            <i class="fas fa-gift"></i> 무료 게임 라이브러리에 추가하기
                        </c:when>
                        <c:when test="${finalAmount < 100 and finalAmount > 0}">
                            <i class="fas fa-exclamation-triangle"></i> 100원 이상부터 결제 가능합니다
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-credit-card"></i> <fmt:formatNumber value="${finalAmount}" type="number" groupingUsed="true"/>원 결제하기
                        </c:otherwise>
                    </c:choose>
                </button>

                <!-- 결제 수단 아이콘 -->
                <div class="payment-methods">
                    <i class="fab fa-cc-visa"></i>
                    <i class="fab fa-cc-mastercard"></i>
                    <i class="fab fa-cc-paypal"></i>
                    <i class="fab fa-cc-amex"></i>
                    <i class="fas fa-mobile-alt"></i>
                    <i class="fas fa-university"></i>
                </div>
            </div>
        </div>
    </section>
    <!-- Checkout Section End -->

    <script>
        // 결제 버튼 이벤트 리스너
        const paymentButton = document.getElementById('payment-button');
        
        if (paymentButton) {
            paymentButton.addEventListener('click', function() {
                // 버튼에 로딩 표시
                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 처리 중...';
                this.disabled = true;
                
                // 0원 결제인 경우
                if (${finalAmount <= 0}) {
                    // 0원 주문 처리 - 바로 결제 성공 페이지로 이동
                    window.location.href = 'paymentSuccess.do?paymentKey=FREE_ORDER&orderId=${paymentOrderId}&amount=0';
                }
                // 100원 미만인 경우 - 버튼 이미 비활성화됨
                else if (${finalAmount < 100 && finalAmount > 0}) {
                    // 아무것도 하지 않음
                    this.disabled = false;
                    this.innerHTML = '<i class="fas fa-exclamation-triangle"></i> 100원 이상부터 결제 가능합니다';
                }
                // 정상 결제
                else {
                    // tossPayment.do로 이동
                    var directBuy = "${param.directBuy}";
                    var gameCode = "${param.gameCode}";
                    var redirectUrl = 'tossPayment.do';
                    
                    if (directBuy === 'true' && gameCode) {
                        redirectUrl += '?directBuy=true&gameCode=' + gameCode;
                    }
                    
                    window.location.href = redirectUrl;
                }
            });
        }
    </script>
</body>
</html>