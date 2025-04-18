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

.cart-item-price {
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
						<c:out value="${cartItems.size()}" />
						개의 상품)
					</h4>

					<!-- 장바구니가 비어있는 경우 -->
					<c:if test="${empty cartItems}">
						<div class="empty-cart">
							<i class="fa fa-shopping-cart"></i>
							<p>장바구니가 비어 있습니다.</p>
							<a href="gamePackage.do" class="continue-shopping">게임 쇼핑하기</a>
						</div>
					</c:if>

					<!-- 장바구니 아이템 목록 -->
					<c:if test="${not empty cartItems}">
						<c:forEach var="item" items="${cartItems}">
							<div class="cart-item" data-cart-id="${item.cartId}">
								<div class="cart-item-image">
									<img src="${item.imgUrl}" alt="${item.gameName}">
								</div>
								<div class="cart-item-details">
									<h5 class="cart-item-title">${item.gameName}</h5>
									<div class="cart-item-edition">${item.editionName}</div>
									<div class="cart-item-price">
										<fmt:formatNumber value="${item.price}" pattern="#,###" />
										원
									</div>
									<div class="quantity-control">
										<button class="quantity-btn decrease-btn"
											data-cart-id="${item.cartId}">-</button>
										<button class="quantity-btn increase-btn"
											data-cart-id="${item.cartId}">+</button>
									</div>
								</div>
								<button class="remove-btn" data-cart-id="${item.cartId}">
									<i class="fa fa-trash"></i>
								</button>
							</div>
						</c:forEach>
					</c:if>
				</div>
			</div>

			<div class="col-lg-4">
				<div class="cart-summary">
					<h4 class="summary-title">주문 요약</h4>
					<div class="summary-row">
						<span>상품 금액</span> <span><fmt:formatNumber
								value="${totalAmount}" pattern="#,###" />원</span>
					</div>
					<div class="summary-row">
						<span>할인</span> <span><fmt:formatNumber
								value="${discountAmount}" pattern="#,###" />원</span>
					</div>
					<div class="summary-total">
						<span>총 결제금액</span> <span><fmt:formatNumber
								value="${totalAmount}" pattern="#,###" />원</span>
					</div>
					<button class="checkout-btn">결제하기</button>

					<div class="payment-methods">
						<i class="fa fa-cc-visa"></i> <i class="fa fa-cc-mastercard"></i>
						<i class="fa fa-cc-paypal"></i> <i class="fa fa-cc-amex"></i>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Cart Section End -->

<!-- Search model Begin -->
<div class="search-model">
	<div class="h-100 d-flex align-items-center justify-content-center">
		<div class="search-close-switch">
			<i class="icon_close"></i>
		</div>
		<form class="search-model-form">
			<input type="text" id="search-input" placeholder="게임 검색...">
		</form>
	</div>
</div>
<!-- Search model end -->

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

		// 삭제 버튼
		$('.remove-btn').click(function() {
			var cartId = $(this).data('cart-id');
			removeCartItem(cartId);
		});

		// 결제 버튼
		$('.checkout-btn').click(function() {
			// 결제 페이지로 이동
			window.location.href = 'checkout.do';
		});

		// 장바구니 아이템 삭제 함수
		function removeCartItem(cartId) {
			if (confirm('정말로 이 상품을 장바구니에서 삭제하시겠습니까?')) {
				$

			}
		}
	});
</script>