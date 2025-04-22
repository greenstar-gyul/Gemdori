<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 완료 - 젬도리</title>
    <!-- 폰트어썸 아이콘 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- 노토 산스 KR 폰트 추가 -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #0b0c2a;
            color: #ffffff;
            margin: 0;
            padding: 0;
        }
        
        .payment-result {
            padding: 50px 0;
        }
        
        .container {
            max-width: 1170px;
            margin: 0 auto;
            padding: 0 15px;
        }
        
        .row {
            display: flex;
            flex-wrap: wrap;
            margin-right: -15px;
            margin-left: -15px;
        }
        
        .justify-content-center {
            justify-content: center;
        }
        
        .col-lg-8 {
            position: relative;
            width: 100%;
            padding-right: 15px;
            padding-left: 15px;
        }
        
        @media screen and (min-width:992px) {
            .col-lg-8 {
                width: 66.666667%;
                margin: 0 auto;
            }
        }
        
        .payment-result-box {
            background-color: #1d1e39;
            padding: 40px;
            border-radius: 8px;
            color: white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.5s ease-in-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .text-center {
            text-align: center;
        }
        
        .success-icon {
            font-size: 80px;
            color: #4CAF50;
            margin-bottom: 20px;
            display: inline-block;
            animation: scaleIn 0.5s ease-in-out;
        }
        
        @keyframes scaleIn {
            from { transform: scale(0); }
            to { transform: scale(1); }
        }
        
        .mb-5 {
            margin-bottom: 3rem;
        }
        
        .mb-3 {
            margin-bottom: 1rem;
        }
        
        .mt-4 {
            margin-top: 1.5rem;
        }
        
        .text-muted {
            color: #b7b7b7 !important;
        }
        
        .order-details {
            margin-bottom: 3rem;
            text-align: left;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding-top: 20px;
        }
        
        .detail-row {
            display: flex;
            margin-bottom: 15px;
            align-items: flex-start;
        }
        
        .detail-label {
            font-weight: 500;
            width: 140px;
            color: #b7b7b7;
        }
        
        .detail-value {
            flex: 1;
        }
        
        .btn {
            display: inline-block;
            font-weight: 600;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            user-select: none;
            border: 1px solid transparent;
            padding: 10px 30px;
            font-size: 1rem;
            line-height: 1.5;
            border-radius: 5px;
            transition: all 0.15s ease-in-out;
            text-decoration: none;
            cursor: pointer;
            margin: 5px;
        }
        
        .btn-danger {
            color: #fff;
            background-color: #e53637;
            border-color: #e53637;
        }
        
        .btn-danger:hover {
            background-color: #d82a2b;
            border-color: #d82a2b;
        }
        
        .btn-outline-light {
            color: #f8f9fa;
            border-color: #f8f9fa;
        }
        
        .btn-outline-light:hover {
            color: #212529;
            background-color: #f8f9fa;
            border-color: #f8f9fa;
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
        
        /* 게임 목록 스타일 */
        .game-list {
            margin-top: 20px;
            padding: 0;
            list-style-type: none;
        }
        
        .game-item {
            background-color: rgba(255, 255, 255, 0.05);
            border-radius: 6px;
            padding: 15px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        
        .game-image {
            width: 60px;
            height: 60px;
            margin-right: 15px;
            border-radius: 6px;
            overflow: hidden;
            background-color: #2c2c3d;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .game-image img {
            max-width: 100%;
            max-height: 100%;
        }
        
        .game-image i {
            font-size: 24px;
            color: #b7b7b7;
        }
        
        .game-details {
            flex: 1;
            text-align: left;
        }
        
        .game-title {
            font-size: 18px;
            font-weight: 600;
            margin: 0 0 5px 0;
        }
        
        .game-edition {
            font-size: 14px;
            color: #b7b7b7;
            margin: 0 0 5px 0;
        }
        
        .game-price {
            font-size: 14px;
            margin: 0;
        }
        
        .original-price {
            text-decoration: line-through;
            color: #b7b7b7;
            margin-right: 10px;
        }
        
        .sale-price {
            color: #e53637;
            font-weight: 600;
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
                        <span>결제 완료</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Payment Result Section Begin -->
    <section class="payment-result">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="payment-result-box">
                        <c:choose>
                            <c:when test="${isSuccess}">
                                <!-- 결제 성공 화면 -->
                                <div class="text-center mb-5">
                                    <i class="fa fa-check-circle success-icon"></i>
                                    <h2 class="mt-4">결제가 완료되었습니다!</h2>
                                    <p class="text-muted">게임이 라이브러리에 성공적으로 추가되었습니다.</p>
                                </div>
                                
                                <!-- 주문 상세 정보 -->
                                <div class="order-details">
                                    <h3 style="margin-bottom: 20px; padding-bottom: 10px; border-bottom: 1px solid rgba(255, 255, 255, 0.1);">
                                        주문 정보
                                    </h3>
                                    
                                    <div class="detail-row">
                                        <div class="detail-label">주문 번호</div>
                                        <div class="detail-value">${jsonObject.orderId}</div>
                                    </div>
                                    
                                    <div class="detail-row">
                                        <div class="detail-label">주문 상품</div>
                                        <div class="detail-value">${jsonObject.orderName}</div>
                                    </div>
                                    
                                    <div class="detail-row">
                                        <div class="detail-label">결제 금액</div>
                                        <div class="detail-value">
                                            <fmt:formatNumber value="${jsonObject.totalAmount}" pattern="#,###" /> 원
                                        </div>
                                    </div>
                                    
                                    <div class="detail-row">
                                        <div class="detail-label">결제 방법</div>
                                        <div class="detail-value">
                                            <c:choose>
                                                <c:when test="${jsonObject.method eq 'card'}">신용카드</c:when>
                                                <c:when test="${jsonObject.method eq 'virtual_account'}">가상계좌</c:when>
                                                <c:when test="${jsonObject.method eq 'transfer'}">계좌이체</c:when>
                                                <c:when test="${jsonObject.method eq 'mobile_phone'}">휴대폰 결제</c:when>
                                                <c:when test="${jsonObject.method eq 'tosspay'}">토스페이</c:when>
                                                <c:when test="${jsonObject.method eq '무료'}">무료</c:when>
                                                <c:otherwise>${jsonObject.method}</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    
                                    <div class="detail-row">
                                        <div class="detail-label">결제 시간</div>
                                        <div class="detail-value">${jsonObject.approvedAt}</div>
                                    </div>
                                </div>
                                
                                <!-- 게임 목록 표시 (옵션) -->
                                <c:if test="${not empty cartItems}">
                                    <div class="game-list-section" style="margin-bottom: 20px;">
                                        <h3 style="margin-bottom: 20px; padding-bottom: 10px; border-bottom: 1px solid rgba(255, 255, 255, 0.1);">
                                            구매한 게임
                                        </h3>
                                        <ul class="game-list">
                                            <c:forEach var="game" items="${cartItems}">
                                                <li class="game-item">
                                                    <div class="game-image">
                                                        <c:choose>
                                                            <c:when test="${not empty game.gameMainImage}">
                                                                <img src="${game.gameMainImage}" alt="${game.gameTitle}">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="fas fa-gamepad"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="game-details">
                                                        <h4 class="game-title">${game.gameTitle}</h4>
                                                        <c:if test="${not empty game.editionName}">
                                                            <p class="game-edition">${game.editionName}</p>
                                                        </c:if>
                                                        <p class="game-price">
                                                            <c:choose>
                                                                <c:when test="${game.gameSalePrice > 0 and game.gameSalePrice < game.gamePrice}">
                                                                    <span class="original-price"><fmt:formatNumber value="${game.gamePrice}" pattern="#,###" />원</span>
                                                                    <span class="sale-price"><fmt:formatNumber value="${game.gameSalePrice}" pattern="#,###" />원</span>
                                                                </c:when>
                                                                <c:when test="${game.gamePrice > 0}">
                                                                    <span class="sale-price"><fmt:formatNumber value="${game.gamePrice}" pattern="#,###" />원</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="sale-price">무료</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                    </div>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </c:if>
                                
                                <!-- 버튼 영역 -->
                                <div class="text-center mt-4">
                                    <a href="main.do" class="btn btn-danger">홈으로</a>
                                    <a href="library.do" class="btn btn-outline-light">내 라이브러리</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- 결제 실패 화면 -->
                                <div class="text-center mb-5">
                                    <i class="fa fa-times-circle" style="font-size: 80px; color: #F44336;"></i>
                                    <h2 class="mt-4">결제에 실패했습니다.</h2>
                                    <p class="text-muted">${jsonObject.message}</p>
                                    <p>에러 코드: ${jsonObject.code}</p>
                                </div>
                                
                                <!-- 버튼 영역 -->
                                <div class="text-center mt-4">
                                    <a href="checkout.do" class="btn btn-danger">다시 시도</a>
                                    <a href="cartPage.do" class="btn btn-outline-light">장바구니로</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Payment Result Section End -->
</body>
</html>