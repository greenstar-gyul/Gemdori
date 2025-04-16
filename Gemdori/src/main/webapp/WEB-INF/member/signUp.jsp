<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Normal Breadcrumb Begin -->
<section class="normal-breadcrumb set-bg"
	data-setbg="img/normal-breadcrumb.jpg">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="normal__breadcrumb__text">
					<h2>Sign Up</h2>
					<p>Welcome to the official Game site.</p>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Normal Breadcrumb End -->

<!-- Signup Section Begin -->
<section class="signup spad">
	<div class="container">

		<form action="/register" method="post" class="col-lg-12">
			<div class="row">
				<!-- 계정 정보 입력 -->
				<div class="col-lg-6">
					<div class="login__form">
						<h3>로그인 정보</h3>
						<div class="input__item input__item-with-btn">
							<input type="email" name="user_email" placeholder="이메일 주소"
								required> <span class="icon_mail"></span>
							<button type="button" id="check-username-btn" class="verify-btn">인증
								요청</button>
						</div>
						<div id="email-code-input-wrap"></div>
						<div class="input__item input__item-with-btn">
							<input type="text" name="user_login_name" placeholder="아이디"
								required> <span class="icon_profile"></span>
							<button type="button" id="send-email-code-btn" class="verify-btn">중복
								확인</button>
						</div>
						<div class="input__item">
							<input type="password" name="user_pw" placeholder="비밀번호" required>
							<span class="icon_lock"></span>
						</div>
						<div class="input__item">
							<input type="password" name="user_cpw" placeholder="비밀번호 확인"
								required> <span class="icon_lock"></span>
						</div>
					</div>
				</div>

				<!-- 프로필 정보 입력 -->
				<div class="col-lg-6">
					<div class="login__form">
						<h3>회원 정보</h3>
						<div class="input__item">
							<input type="text" name="user_name" placeholder="닉네임" required>
							<span class="icon_profile"></span>
						</div>
						<div class="input__item">
							<input type="text" name="user_first_name" placeholder="이름"
								required> <span class="icon_profile"></span>
						</div>
						<div class="input__item">
							<input type="text" name="user_last_name" placeholder="성" required>
							<span class="icon_profile"></span>
						</div>
						<div class="input__item">
							<input type="text" name="user_phone" placeholder="전화번호">
							<span class="icon_phone"></span>
						</div>
						<div class="input__item">
							<input type="text" id="user_birthday" name="user_birthday"
								placeholder="생년월일 선택"> <span class="icon_calendar"></span>
						</div>
						<div class="select__item">
							<select id="user_gender" name="user_gender" required>
								<option value="">성별 선택</option>
								<option value="M">남</option>
								<option value="F">여</option>
							</select>
						</div>
					</div>
				</div>

				<!-- 버튼 영역: 전체 너비 아래 중앙 정렬 -->
				<div class="col-lg-12 text-center" style="margin-top: 30px;">
					<button type="submit" class="site-btn">회원가입</button>
					<a href="login.do" class="site-btn" style="margin-left: 10px;">가입취소</a>
				</div>
			</div>
		</form>
	</div>
</section>
<!-- Signup Section End -->
<link rel="stylesheet" href="css/gemdori/signUp.css" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css"> <!-- 날짜 선택 -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script> <!-- 날짜 선택 -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script> <!-- 날짜 선택 한국어 변경 -->
<script>
	document.addEventListener('DOMContentLoaded', function () {
	flatpickr("#user_birthday", {
	dateFormat: "Y-m-d",
	locale: flatpickr.l10ns.ko
		});
	});
	
	document.addEventListener("DOMContentLoaded", function () {
	    const verifyBtn = document.getElementById("check-username-btn");
	    const codeInputWrap = document.getElementById("email-code-input-wrap");

	    verifyBtn.addEventListener("click", function () {
	        // 중복 생성 방지
	        if (document.getElementById("email_code")) return;

	        // wrapper div
	        const wrapper = document.createElement("div");
	        wrapper.className = "input__item input__item-with-btn";

	        // input
	        const input = document.createElement("input");
	        input.type = "text";
	        input.name = "email_code";
	        input.id = "email_code";
	        input.placeholder = "인증번호 입력";
	        input.required = true;

	        // 아이콘 (선택)
	        const icon = document.createElement("span");
	        icon.className = "icon_key"; // 원하는 아이콘 class로 변경 가능

	        // 버튼
	        const checkBtn = document.createElement("button");
	        checkBtn.type = "button";
	        checkBtn.className = "verify-btn";
	        checkBtn.innerText = "인증 확인";

	        // 조립
	        wrapper.appendChild(input);
	        wrapper.appendChild(icon);
	        wrapper.appendChild(checkBtn);

	        // 삽입
	        codeInputWrap.appendChild(wrapper);
	    });
	});
</script>