<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 실패 - 젬도리</title>
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
        
        .error-icon {
            font-size: 80px;
            color: #F44336;
            margin-bottom: 20px;
            display: inline-block;
            animation: shake 0.5s ease-in-out;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-10px); }
            20%, 40%, 60%, 80% { transform: translateX(10px); }
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
        
        .error-details {
            background-color: rgba(244, 67, 54, 0.1);
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
            text-align: left;
        }
        
        .error-details h4 {
            color: #F44336;
            margin-top: 0;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        
        .error-details h4 i {
            margin-right: 10px;
        }
        
        .error-details p {
            margin: 10px 0;
        }
        
        .error-code {
            font-family: monospace;
            background-color: rgba(0, 0, 0, 0.2);
            padding: 5px 10px;
            border-radius: 3px;
            margin-left: 5px;
        }
        
        .troubleshooting-tips {
            background-color: rgba(255, 255, 255, 0.05);
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
        }
        
        .troubleshooting-tips h4 {
            margin-top: 0;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        
        .troubleshooting-tips h4 i {
            margin-right: 10px;
            color: #FFD54F;
        }
        
        .troubleshooting-tips ul {
            padding-left: 20px;
            margin: 0;
        }
        
        .troubleshooting-tips li {
            margin-bottom: 10px;
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
            margin: 5px 10px;
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
	                    <c:choose>
	                        <c:when test="${directBuy eq 'true' and not empty gameCode}">
	                            <a href="./gameDetails.do?gameCode=${gameCode}">게임 상세</a>
	                        </c:when>
	                        <c:otherwise>
	                            <a href="./cartPage.do">장바구니</a>
	                        </c:otherwise>
	                    </c:choose>
	                    <a href="./checkout.do">결제하기</a>
	                    <span>결제 실패</span>
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
                        <!-- 결제 실패 화면 -->
                        <div class="text-center mb-5">
                            <i class="fa fa-times-circle error-icon"></i>
                            <h2 class="mt-4">결제에 실패했습니다 ㅠㅠ</h2>
                            <p class="text-muted">아래 오류 내용을 확인하고 다시 시도해보세요!</p>
                        </div>
                        
                        <!-- 오류 상세 정보 -->
                        <div class="error-details">
                            <h4><i class="fas fa-exclamation-triangle"></i> 오류 정보</h4>
                            <p><strong>오류 메시지:</strong> ${jsonObject.message}</p>
                            <p><strong>오류 코드:</strong> <span class="error-code">${jsonObject.code}</span></p>
                            <c:if test="${not empty jsonObject.orderId}">
                                <p><strong>주문 번호:</strong> ${jsonObject.orderId}</p>
                            </c:if>
                        </div>
                        
                        <!-- 문제 해결 팁 -->
                        <div class="troubleshooting-tips">
                            <h4><i class="fas fa-lightbulb"></i> 이렇게 해결해보세요</h4>
                            <ul>
                                <li>카드 정보가 올바르게 입력되었는지 확인해보세요.</li>
                                <li>선택한 결제 수단의 잔액이 충분한지 확인해보세요.</li>
                                <li>결제 한도를 초과했거나 제한이 걸려있는지 확인해보세요.</li>
                                <li>다른 결제 수단을 이용해보세요.</li>
                                <li>문제가 지속되면 고객센터(<a href="mailto:support@gemdori.com" style="color: #64a8ff;">support@gemdori.com</a>)로 문의해주세요.</li>
                            </ul>
                        </div>
                        
                        <!-- 버튼 영역 -->
						<div class="text-center mt-4">
						    <c:choose>
						        <c:when test="${directBuy eq 'true' and not empty gameCode}">
						            <a href="checkout.do?directBuy=true&gameCode=${gameCode}" class="btn btn-danger">다시 시도하기</a>
						            <a href="gameDetails.do?gameCode=${gameCode}" class="btn btn-outline-light">게임 상세로 돌아가기</a>
						        </c:when>
						        <c:otherwise>
						            <a href="checkout.do" class="btn btn-danger">다시 시도하기</a>
						            <a href="cartPage.do" class="btn btn-outline-light">장바구니로 돌아가기</a>
						        </c:otherwise>
						    </c:choose>
						</div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Payment Result Section End -->
</body>
</html>