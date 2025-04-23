<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<section class="payment-result spad">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="payment-result-box" style="background-color: #1d1e39; padding: 40px; border-radius: 5px; color: white;">
                    <c:choose>
                        <c:when test="${isSuccess}">
                            <!-- 결제 성공 화면 -->
                            <div class="text-center mb-5">
                                <i class="fa fa-check-circle" style="font-size: 80px; color: #4CAF50;"></i>
                                <h2 class="mt-4" style="color: white;">결제가 완료되었습니다!</h2>
                                <p class="text-muted">주문하신 상품은 곧 이메일로 전송됩니다.</p>
                            </div>
                            
                            <!-- 주문 상세 정보 -->
                            <div class="order-details mb-5">
                                <h4 style="color: white; border-bottom: 1px solid rgba(255, 255, 255, 0.1); padding-bottom: 15px; margin-bottom: 20px;">주문 정보</h4>
                                
                                <div class="row mb-3">
                                    <div class="col-md-4">
                                        <p><strong>주문 번호:</strong></p>
                                    </div>
                                    <div class="col-md-8">
                                        <p>${jsonObject.orderId}</p>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-4">
                                        <p><strong>주문 상품:</strong></p>
                                    </div>
                                    <div class="col-md-8">
                                        <p>${jsonObject.orderName}</p>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-4">
                                        <p><strong>결제 금액:</strong></p>
                                    </div>
                                    <div class="col-md-8">
                                        <p><fmt:formatNumber value="${jsonObject.totalAmount}" pattern="#,###" /> 원</p>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-4">
                                        <p><strong>결제 방법:</strong></p>
                                    </div>
                                    <div class="col-md-8">
                                        <p>
                                            <c:choose>
                                                <c:when test="${jsonObject.method eq 'card'}">신용카드</c:when>
                                                <c:when test="${jsonObject.method eq 'virtual_account'}">가상계좌</c:when>
                                                <c:when test="${jsonObject.method eq 'transfer'}">계좌이체</c:when>
                                                <c:when test="${jsonObject.method eq 'mobile_phone'}">휴대폰 결제</c:when>
                                                <c:otherwise>${jsonObject.method}</c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-4">
                                        <p><strong>결제 시간:</strong></p>
                                    </div>
                                    <div class="col-md-8">
                                        <p>${jsonObject.approvedAt}</p>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 버튼 영역 -->
                            <div class="text-center mt-4">
                                <a href="main.do" class="btn btn-danger" style="background-color: #e53637; border: none; padding: 10px 30px; margin-right: 10px;">홈으로</a>
                                <a href="#" class="btn btn-outline-light" style="padding: 10px 30px;">주문 내역</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- 결제 실패 화면 -->
                            <div class="text-center mb-5">
                                <i class="fa fa-times-circle" style="font-size: 80px; color: #F44336;"></i>
                                <h2 class="mt-4" style="color: white;">결제에 실패했습니다.</h2>
                                <p class="text-muted">${jsonObject.message}</p>
                                <p>에러 코드: ${jsonObject.code}</p>
                            </div>
                            
                            <!-- 버튼 영역 -->
                            <div class="text-center mt-4">
                                <a href="checkout.do" class="btn btn-danger" style="background-color: #e53637; border: none; padding: 10px 30px; margin-right: 10px;">다시 시도</a>
                                <a href="cartPage.do" class="btn btn-outline-light" style="padding: 10px 30px;">장바구니로</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Payment Result Section End -->