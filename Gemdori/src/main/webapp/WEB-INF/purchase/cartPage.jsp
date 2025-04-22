<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="en" xmlns:th="http://www.thymeleaf.org">

<style>
.cart-container {
	background-color: #1d1e39;
	padding: 30px;
	border-radius: 5px;
	margin-bottom: 30px;
}

.cart-title {
	color: #ffffff;
	margin-bottom: 30px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
	padding-bottom: 15px;
}

.cart-item {
	display: flex;
	background-color: #0b0c2a;
	border-radius: 5px;
	padding: 15px;
	margin-bottom: 15px;
	position: relative;
}

.cart-item-image {
	width: 120px;
	height: 150px;
	border-radius: 5px;
	overflow: hidden;
	margin-right: 20px;
}

.cart-item-image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.cart-item-details {
	flex-grow: 1;
}

.cart-item-title {
	color: #ffffff;
	font-size: 18px;
	margin-bottom: 5px;
}

.cart-item-edition {
	color: #e53637;
	font-size: 14px;
	margin-bottom: 10px;
}

.cart-item-gamePrice {
	color: #ffffff;
	font-size: 22px;
	font-weight: 600;
	margin-bottom: 15px;
}

.quantity-control {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
}

.quantity-btn {
	width: 30px;
	height: 30px;
	background-color: #e53637;
	border: none;
	color: white;
	font-size: 16px;
	cursor: pointer;
	border-radius: 3px;
}

.quantity-input {
	width: 50px;
	text-align: center;
	margin: 0 10px;
	background-color: #1d1e39;
	border: 1px solid rgba(255, 255, 255, 0.2);
	color: white;
	padding: 5px;
	border-radius: 3px;
}

.remove-btn {
	position: absolute;
	top: 15px;
	right: 15px;
	background-color: transparent;
	border: none;
	color: #777;
	font-size: 18px;
	cursor: pointer;
}

.remove-btn:hover {
	color: #e53637;
}

.cart-summary {
	background-color: #0b0c2a;
	padding: 20px;
	border-radius: 5px;
	margin-bottom: 30px;
}

.summary-title {
	color: #ffffff;
	margin-bottom: 20px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
	padding-bottom: 10px;
}

.summary-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 10px;
	color: #b7b7b7;
}

.summary-total {
	display: flex;
	justify-content: space-between;
	margin-top: 20px;
	padding-top: 15px;
	border-top: 1px solid rgba(255, 255, 255, 0.1);
	color: #ffffff;
	font-size: 22px;
	font-weight: 600;
}

.checkout-btn {
	width: 100%;
	background-color: #e53637;
	color: white;
	border: none;
	padding: 15px;
	font-size: 18px;
	margin-top: 20px;
	cursor: pointer;
	border-radius: 5px;
	transition: all 0.3s;
}

.checkout-btn:hover {
	background-color: #d82a2b;
}

.empty-cart {
	text-align: center;
	padding: 50px 0;
	color: #b7b7b7;
}

.empty-cart i {
	font-size: 48px;
	color: #e53637;
	margin-bottom: 20px;
}

.empty-cart p {
	font-size: 18px;
	margin-bottom: 30px;
}

.continue-shopping {
	background-color: #e53637;
	color: white;
	text-decoration: none;
	padding: 10px 20px;
	border-radius: 5px;
	transition: all 0.3s;
}

.continue-shopping:hover {
	background-color: #d82a2b;
	color: white;
}

.payment-methods {
	display: flex;
	justify-content: center;
	gap: 15px;
	margin-top: 20px;
}

.payment-methods i {
	font-size: 24px;
	color: #b7b7b7;
}

/* 로딩 스피너 */
.loading-spinner {
    display: none;
    text-align: center;
    padding: 20px;
}

.loading-spinner i {
    font-size: 24px;
    color: #e53637;
    animation: spin 1s infinite linear;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}
</style>

<!-- Page Preloder -->
<div id="preloder">
	<div class="loader"></div>
</div>

<!-- Breadcrumb Begin -->
<div class="breadcrumb-option">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="breadcrumb__links">
					<a href="./index.do"><i class="fa fa-home"></i> 홈</a> <span>장바구니</span>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Breadcrumb End -->

<!-- Cart Section Begin -->
<section class="cart-section spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-8">
				<div class="cart-container">
					<h4 class="cart-title">
						장바구니 (
						<span id="cart-count"><c:out value="${cartItems.size()}" /></span>
						개의 상품)
					</h4>

					<!-- 장바구니가 비어있는 경우 -->
					<c:if test="${empty cartItems}">
						<div class="empty-cart">
							<i class="fa fa-shopping-cart"></i>
							<p>장바구니가 비어 있습니다.</p>
							<a href="searchGames.do" class="continue-shopping">게임 쇼핑하기</a>
						</div>
					</c:if>

                    <!-- 로딩 스피너 -->
                    <div class="loading-spinner" id="cart-loading">
                        <i class="fa fa-spinner"></i>
                        <p>처리 중입니다...</p>
                    </div>

					<!-- 장바구니 아이템 목록 -->
					<div id="cart-items-container">
						<c:if test="${not empty cartItems}">
							<c:forEach var="item" items="${cartItems}">
								<div class="cart-item" data-cart-id="${item.cartCode}">
									<div class="cart-item-image">
										<img src="${item.gameMainImage}" alt="${item.gameTitle}">
									</div>
									<div class="cart-item-details">
										<h5 class="cart-item-title">${item.gameTitle}</h5>
										<div class="cart-item-edition">${item.editionName}</div>
										<div class="cart-item-gamePrice">
											<c:choose>
												<c:when test="${item.gameSalePrice > 0 && item.gameSalePrice < item.gamePrice}">
													<span style="text-decoration: line-through; color: #b7b7b7; font-size: 16px; margin-right: 10px;">
														<fmt:formatNumber value="${item.gamePrice}" pattern="#,###" />원
													</span>
													<fmt:formatNumber value="${item.gameSalePrice}" pattern="#,###" />원
													<span style="color: #3fd13f; font-size: 14px; margin-left: 10px;">
														<c:set var="discountRate" value="${100 - ((item.gameSalePrice / item.gamePrice) * 100)}" />
														<fmt:formatNumber value="${discountRate}" pattern="#,##0" />% 할인
													</span>
												</c:when>
												<c:otherwise>
													<fmt:formatNumber value="${item.gamePrice}" pattern="#,###" />원
												</c:otherwise>
											</c:choose>
										</div>
										<div class="quantity-control">
											<button class="remove-btn" data-cart-id="${item.cartCode}" onclick="removeCartItem('${item.cartCode}')">
												<i class="fa fa-trash"></i> 삭제
											</button>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:if>
					</div>
				</div>
			</div>

			<div class="col-lg-4">
				<div class="cart-summary">
					<h4 class="summary-title">주문 요약</h4>
					<div class="summary-row">
						<span>상품 금액</span> <span id="total-amount"><fmt:formatNumber
								value="${totalAmount}" pattern="#,###" />원</span>
					</div>
					<div class="summary-row">
						<span>할인</span> <span id="discount-amount"><fmt:formatNumber
								value="${discountAmount}" pattern="#,###" />원</span>
					</div>
					<div class="summary-total">
					    <span>총 결제금액</span> <span id="final-amount"><fmt:formatNumber
					            value="${finalAmount}" pattern="#,###" />원</span>
					</div>
					<button class="checkout-btn" id="checkout-button">결제하기</button>

					<div class="payment-methods">
						<i class="fab fa-cc-visa"></i> 
                        <i class="fab fa-cc-mastercard"></i>
						<i class="fab fa-cc-paypal"></i> 
                        <i class="fab fa-cc-amex"></i>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Cart Section End -->

<!-- Js Plugins -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/player.js"></script>
<script src="js/jquery.nice-select.min.js"></script>
<script src="js/mixitup.min.js"></script>
<script src="js/jquery.slicknav.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/main.js"></script>

<script>
$(document).ready(function() {
    // 결제 버튼
    $('#checkout-button').click(function() {
        // 결제 페이지로 이동
        window.location.href = 'checkout.do';
    });
});

//30초마다 장바구니 상태 체크
setInterval(function() {
    $.ajax({
        url: 'getCartSummary.do',
        type: 'GET',
        dataType: 'json',
        cache: false,
        success: function(data) {
            // DB 상태와 화면 상태가 다르면 새로고침
            if (data.itemCount !== parseInt($('#cart-count').text())) {
                location.reload(true);
            }
        }
    });
}, 30000);

function removeCartItem(cartCode) {
    if (confirm('정말로 이 상품을 장바구니에서 삭제하시겠습니까?')) {
        // 로딩 스피너 표시
        $('#cart-loading').show();
        
        // 삭제 요청 전송
        $.ajax({
            url: 'removeCartItem.do',
            type: 'POST',
            data: { cartCode: cartCode },
            cache: false,
            success: function(response) {
                if (response === "success") {
                    // 강제로 서버에서 새로 데이터 가져오기 (캐시 무시)
                    window.location.replace('cartPage.do?refresh=' + new Date().getTime());
                } else {
                    $('#cart-loading').hide();
                    alert('상품 삭제 중 오류가 발생했습니다. 다시 시도해주세요.');
                }
            },
            error: function() {
                $('#cart-loading').hide();
                alert('상품 삭제 중 오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    }
}

//장바구니 요약 정보 업데이트 함수 수정
function updateCartSummary() {
    $.ajax({
        url: 'getCartSummary.do',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            // 요약 정보 업데이트
            $('#total-amount').text(numberWithCommas(data.totalAmount) + '원');
            $('#discount-amount').text(numberWithCommas(data.discountAmount) + '원');
            $('#final-amount').text(numberWithCommas(data.finalAmount) + '원'); // 직접 계산 대신 서버에서 받은 값 사용
            $('#cart-loading').hide();
        },
        error: function() {
            // 에러 시 페이지를 새로고침하는 방식으로 폴백
            location.reload(true);
        }
    });
}

// 숫자 포맷팅 함수 (천 단위 콤마)
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
</script>