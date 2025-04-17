<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.header {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	z-index: 1000;
	background-color: #000;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}

body {
	padding-top: 70px;
}

.checkout-section {
	padding: 40px 0;
	color: #ffffff;
}

.section-title {
	margin-bottom: 30px;
}

.checkout-form {
	background-color: #1d1e39;
	border-radius: 5px;
	padding: 30px;
	margin-bottom: 30px;
}

.checkout-form h3 {
	color: white;
	margin-bottom: 20px;
	padding-bottom: 15px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
	font-size: 20px;
}

.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	font-weight: 500;
}

.form-control {
	width: 100%;
	padding: 12px 15px;
	background-color: #151522;
	border: 1px solid rgba(255, 255, 255, 0.1);
	border-radius: 5px;
	color: #fff;
	font-size: 14px;
}

.form-control:focus {
	border-color: #e53637;
	outline: none;
}

.radio-group {
	display: flex;
	flex-wrap: wrap;
	gap: 15px;
}

.radio-item {
	display: flex;
	align-items: center;
	background-color: #151522;
	border: 1px solid rgba(255, 255, 255, 0.1);
	border-radius: 5px;
	padding: 12px 15px;
	cursor: pointer;
	transition: all 0.3s;
	flex-basis: calc(50% - 8px);
}

.radio-item.active {
	border-color: #e53637;
}

.radio-item input[type="radio"] {
	margin-right: 10px;
}

.radio-item:hover {
	border-color: rgba(255, 255, 255, 0.3);
}

.order-summary {
	background-color: #1d1e39;
	border-radius: 5px;
	padding: 30px;
	height: 100%;
}

.order-summary h3 {
	margin-bottom: 20px;
	padding-bottom: 15px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
	font-size: 20px;
}

.order-item {
	display: flex;
	align-items: center;
	margin-bottom: 15px;
	padding-bottom: 15px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.order-item:last-child {
	border-bottom: none;
}

.order-item-img {
	width: 60px;
	height: 60px;
	border-radius: 5px;
	overflow: hidden;
	margin-right: 15px;
}

.order-item-img img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.order-item-info {
	flex-grow: 1;
}

.order-item-title {
	font-weight: 500;
	font-size: 14px;
	margin-bottom: 5px;
}

.order-item-details {
	color: #b7b7b7;
	font-size: 12px;
}

.order-item-price {
	color: #e53637;
	font-weight: 600;
	font-size: 14px;
	white-space: nowrap;
}

.order-total-item {
	display: flex;
	justify-content: space-between;
	margin-bottom: 15px;
	color: #b7b7b7;
}

.order-total-final {
	display: flex;
	justify-content: space-between;
	margin-top: 20px;
	padding-top: 15px;
	border-top: 1px solid rgba(255, 255, 255, 0.1);
	font-size: 18px;
	font-weight: 600;
	color: #ffffff;
}

.complete-payment-btn {
	display: block;
	width: 100%;
	background-color: #e53637;
	color: #ffffff;
	border: none;
	padding: 15px 0;
	border-radius: 5px;
	text-align: center;
	font-weight: 600;
	margin-top: 20px;
	cursor: pointer;
	transition: all 0.3s;
	text-transform: uppercase;
	letter-spacing: 1px;
}

.complete-payment-btn:hover {
	background-color: #ff4a4a;
}

.card-inputs {
	display: grid;
	grid-template-columns: 1fr 1fr;
	grid-gap: 15px;
}

.expiry-cvv {
	display: grid;
	grid-template-columns: 1fr 1fr;
	grid-gap: 15px;
}

.payment-method-icons {
	display: flex;
	gap: 10px;
	margin-top: 10px;
}

.payment-method-icons i {
	font-size: 24px;
	color: #b7b7b7;
}

.secure-badge {
	display: flex;
	align-items: center;
	margin-top: 20px;
	color: #b7b7b7;
	font-size: 14px;
}

.secure-badge i {
	color: #76c043;
	margin-right: 10px;
	font-size: 18px;
}

.checkout-back {
	display: inline-block;
	margin-top: 20px;
	color: #b7b7b7;
	transition: all 0.3s;
}

.checkout-back:hover {
	color: #e53637;
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
					<a href="./index.html"><i class="fa fa-home"></i> 홈</a> <a
						href="./cart.html">장바구니</a> <span>결제하기</span>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Breadcrumb End -->

<!-- Checkout Section Begin -->
<section class="checkout-section spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="section-title">
					<h4>결제하기</h4>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-8">
				<!-- 배송 정보 -->
				<div class="checkout-form">
					<h3>이메일 정보</h3>
					<div class="form-group">
						<label for="email">이메일 주소 (디지털 제품 전송용)</label> <input type="email"
							id="email" class="form-control" placeholder="example@email.com">
					</div>
					<div class="form-group">
						<label for="confirm-email">이메일 주소 확인</label> <input type="email"
							id="confirm-email" class="form-control"
							placeholder="example@email.com">
					</div>
				</div>

				<!-- 결제 수단 -->
				<div class="checkout-form">
					<h3>결제 수단 선택</h3>
					<div class="form-group">
						<div class="radio-group">
							<label class="radio-item active"> <input type="radio"
								name="payment-method" value="card" checked> 신용카드 / 체크카드
							</label> <label class="radio-item"> <input type="radio"
								name="payment-method" value="virtual-account"> 가상계좌
							</label> <label class="radio-item"> <input type="radio"
								name="payment-method" value="phone"> 휴대폰 결제
							</label> <label class="radio-item"> <input type="radio"
								name="payment-method" value="kakao-pay"> 카카오페이
							</label>
						</div>
					</div>

					<!-- 신용카드 입력 폼 -->
					<div id="card-payment-form">
						<div class="form-group">
							<label for="card-holder">카드 소유자 이름</label> <input type="text"
								id="card-holder" class="form-control" placeholder="카드에 표시된 이름">
						</div>
						<div class="form-group">
							<label for="card-number">카드 번호</label> <input type="text"
								id="card-number" class="form-control"
								placeholder="0000 0000 0000 0000">
						</div>
						<div class="form-group expiry-cvv">
							<div>
								<label for="expiry-date">만료일</label> <input type="text"
									id="expiry-date" class="form-control" placeholder="MM / YY">
							</div>
							<div>
								<label for="cvv">CVV</label> <input type="text" id="cvv"
									class="form-control" placeholder="123">
							</div>
						</div>
						<div class="payment-method-icons">
							<i class="fa fa-cc-visa"></i> <i class="fa fa-cc-mastercard"></i>
							<i class="fa fa-cc-amex"></i> <i class="fa fa-credit-card"></i>
						</div>
					</div>
				</div>

				<!-- 개인정보 수집 동의 -->
				<div class="checkout-form">
					<h3>개인정보 수집 및 이용 동의</h3>
					<div class="form-group">
						<div class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input"
								id="terms-agree"> <label class="custom-control-label"
								for="terms-agree" style="color: white; cursor: pointer;">
								개인정보 수집 및 이용에 동의합니다. (필수) </label>
						</div>
					</div>
					<div class="form-group">
						<div class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input"
								id="marketing-agree"> <label
								class="custom-control-label" for="marketing-agree"
								style="color: white; cursor: pointer;"> 마케팅 정보 수신에
								동의합니다. (선택) </label>
						</div>
					</div>

					<div class="secure-badge">
						<i class="fa fa-lock"></i> 안전한 결제를 위해 128비트 SSL 암호화를 사용합니다.
					</div>
				</div>

				<a href="./cart.html" class="checkout-back"><i
					class="fa fa-angle-left"></i> 장바구니로 돌아가기</a>
			</div>
			<div class="col-lg-4">
				<div class="order-summary">
					<h3>주문 요약</h3>

					<!-- 주문 내역 -->
					<div class="order-item">
						<div class="order-item-img">
							<img src="img/trending/trend-1.jpg" alt="">
						</div>
						<div class="order-item-info">
							<h5 class="order-item-title">엘든 링: 쉐도우 오브 더 어드리 트리</h5>
							<div class="order-item-details">디럭스 에디션</div>
						</div>
						<div class="order-item-price">58,000원</div>
					</div>
					<div class="order-item">
						<div class="order-item-img">
							<img src="img/trending/trend-3.jpg" alt="">
						</div>
						<div class="order-item-info">
							<h5 class="order-item-title">사이버펑크 2077</h5>
							<div class="order-item-details">스탠다드 에디션</div>
						</div>
						<div class="order-item-price">36,000원</div>
					</div>
					<div class="order-item">
						<div class="order-item-img">
							<img src="img/sidebar/tv-1.jpg" alt="">
						</div>
						<div class="order-item-info">
							<h5 class="order-item-title">엘든링 - 갑옷 스킨 팩</h5>
							<div class="order-item-details">DLC</div>
						</div>
						<div class="order-item-price">12,000원</div>
					</div>

					<!-- 합계 -->
					<div class="order-total-item">
						<span>상품 금액</span> <span>106,000원</span>
					</div>
					<div class="order-total-item">
						<span>할인 금액</span> <span>0원</span>
					</div>
					<div class="order-total-item">
						<span>부가세 (VAT)</span> <span>포함</span>
					</div>
					<div class="order-total-final">
						<span>총 결제 금액</span> <span style="color: #e53637;">106,000원</span>
					</div>

					<button type="submit" class="complete-payment-btn">결제 완료하기</button>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Checkout Section End -->

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
	$(document).ready(
			function() {
				// 결제 방법 라디오 버튼 처리
				$('.radio-item').on(
						'click',
						function() {
							$('.radio-item').removeClass('active');
							$(this).addClass('active');
							$(this).find('input[type="radio"]').prop('checked',
									true);

							// 여기에 결제 방법에 따른 폼 표시/숨김 로직 추가
							var paymentMethod = $(
									'input[name="payment-method"]:checked')
									.val();
							if (paymentMethod === 'card') {
								$('#card-payment-form').show();
							} else {
								$('#card-payment-form').hide();
							}
						});

				// 결제 완료 버튼 클릭 처리
				$('.complete-payment-btn').on('click', function(e) {
					e.preventDefault();
					// 여기에 결제 처리 로직 추가 (JSP로 구현 예정)
					alert('결제가 완료되었습니다!');
					window.location.href = 'cartPage.do';
				});
			});
</script>