<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제하기</title>
    <link rel="icon" href="https://static.toss.im/icons/png/4x/icon-toss-logo.png" />
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- 토스페이먼츠 SDK 추가 -->
    <script src="https://js.tosspayments.com/v2/standard"></script>
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
</head>
<body style="background-color: #0b0c2a;">

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
					<h4 style="color: white;">결제하기</h4>
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

				<!-- 주문자 정보 -->
				<div class="checkout-form">
					<h3>주문자 정보</h3>
					<div class="form-group">
						<label for="customer-name">이름</label> 
						<input type="text" id="customer-name" class="form-control" placeholder="주문자 이름">
					</div>
					<div class="form-group">
						<label for="customer-mobile">전화번호</label> 
						<input type="text" id="customer-mobile" class="form-control" placeholder="010-0000-0000">
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

					<button type="button" id="payment-button" class="complete-payment-btn">결제 완료하기</button>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // 현재 URL 가져오기 (context path 포함)
    let currentURL = window.location.origin + window.location.pathname.substring(0, window.location.pathname.lastIndexOf('/') + 1);

    // 결제 정보 설정
    const amount = {
        value: 100, // 총 결제 금액 (원 단위)
        currency: "KRW" // 통화
    };

    // 고유한 주문번호 생성 함수
    function generateOrderId() {
        return 'order_' + new Date().getTime() + '_' + Math.floor(Math.random() * 1000);
    }

    // 결제 초기화 (토스페이먼츠 SDK)
    const clientKey = "test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq"; // 테스트용 클라이언트 키
    const customerKey = 'CUSTOMER_' + new Date().getTime(); // 고객 고유 번호
    const tossPayments = TossPayments(clientKey);
    // payment 객체 초기화
    const payment = tossPayments.payment({
        customerKey: customerKey
    });

    $(document).ready(function() {
        // 페이지 로드 시 초기화 코드
        $(document).ready(function() {
            // 여기에 필요한 초기화 코드 추가
        });

        // 결제 버튼 클릭 시 처리
        $('#payment-button').on('click', function(e) {
            e.preventDefault();
            
            // 폼 유효성 검사
            if (!validateForm()) {
                return;
            }

            // 고객 정보 가져오기
            const customerName = $('#customer-name').val();
            const customerEmail = $('#email').val();
            const customerMobilePhone = $('#customer-mobile').val();
            const orderId = generateOrderId();
            
            // 결제 요청 - 기본 결제 수단을 CARD로 설정
            payment.requestPayment({
                method: "CARD", // 기본 결제 수단
                amount: amount, // 결제 금액 객체
                orderId: orderId, // 주문 ID
                orderName: "게임 디지털 제품 구매", // 주문명
                customerName: customerName, // 고객명
                customerEmail: customerEmail, // 고객 이메일
                customerMobilePhone: customerMobilePhone, // 고객 전화번호
                // 절대 경로로 success.jsp와 fail.jsp 경로 설정
                successUrl: window.location.origin + "/Gemdori/success.do", // 결제 성공 시 리다이렉트 URL
                failUrl: window.location.origin + "/Gemdori/fail.jsp", // 결제 실패 시 리다이렉트 URL
            })
            .catch(function(error) {
                // 에러 처리
                console.error("결제 요청 에러:", error);
                if (error.code === "USER_CANCEL") {
                    alert("결제가 취소되었습니다.");
                } else {
                    alert("결제 중 오류가 발생했습니다: " + error.message);
                }
            });
        });

        // 폼 유효성 검사 함수
        function validateForm() {
            const email = $('#email').val();
            const confirmEmail = $('#confirm-email').val();
            const customerName = $('#customer-name').val();
            
            if (!email) {
                alert("이메일 주소를 입력해주세요.");
                $('#email').focus();
                return false;
            }
            
            if (email !== confirmEmail) {
                alert("이메일 주소가 일치하지 않습니다.");
                $('#confirm-email').focus();
                return false;
            }
            
            if (!customerName) {
                alert("이름을 입력해주세요.");
                $('#customer-name').focus();
                return false;
            }
            
            if (!$('#terms-agree').is(':checked')) {
                alert("개인정보 수집 및 이용에 동의해주세요.");
                return false;
            }
            
            return true;
        }
    });
</script>
</body>
</html>