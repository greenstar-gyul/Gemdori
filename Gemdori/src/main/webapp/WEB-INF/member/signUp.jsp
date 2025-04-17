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

		<form id="signUpForm" action="signUp.do" method="post" class="col-lg-12">
			<div class="row">
				<!-- 계정 정보 입력 -->
				<div class="col-lg-6">
					<div class="login__form">
						<h3>로그인 정보</h3>
						<div class="input__item input__item-with-btn">
							<input type="email" id="userEmail" name="userEmail" placeholder="이메일 주소"
								required> <span class="icon_mail"></span>
							<button type="button" id="check-username-btn" class="verify-btn">인증
								요청</button>
						</div>
						<div id="email-code-input-wrap"></div>
						<div class="input__item input__item-with-btn">
							<input type="text" name="userId" id="userId" placeholder="아이디 (6~12자)" required minlength="6" maxlength="12"><span class="icon_profile"></span>
							<button type="button" id="send-email-code-btn" class="verify-btn">중복
								확인</button>
						<div id="id-check-result" style="color: green; font-size: 0.9em; margin-top: 5px;"></div>
						</div>
						<div class="input__item">
							<input type="password" name="userPw" id="userPw" placeholder="비밀번호 (8~16자)" required minlength="8" maxlength="16">
							<span class="icon_lock"></span>
						</div>
						<div class="input__item">
							<input type="password" name="userCpw" id="userCpw" placeholder="비밀번호 확인" required onblur="checkPasswordMatch()"><span class="icon_lock"></span>
						</div>
					</div>
				</div>

				<!-- 프로필 정보 입력 -->
				<div class="col-lg-6">
					<div class="login__form">
						<h3>회원 정보</h3>
						<div class="input__item">
							<input type="text" name="userName" id="userName" placeholder="닉네임 (2~8자)" required minlength="2" maxlength="8">
							<span class="icon_profile"></span>
						</div>
						<div class="input__item">
							<input type="text" name="userFirstName" id="userFirstName" placeholder="이름 (1~8자)" required maxlength="8"><span class="icon_profile"></span>
						</div>
						<div class="input__item">
							<input type="text" name="userLastName" id="userLastName" placeholder="성 (1~4자)" required maxlength="4">
							<span class="icon_profile"></span>
						</div>
						<div class="input__item">
							<input type="text" name="userPhone" id="userPhone" placeholder="전화번호 (11자리 숫자만 입력)" required minlength="11" maxlength="11">
							<span class="icon_phone"></span>
						</div>
						<div class="input__item">
							<input type="text" id="user_birthday" name="userBirthday"
								placeholder="생년월일 선택"> <span class="icon_calendar"></span>
						</div>
						<div class="select__item">
							<select id="user_gender" name="userGender">
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
					<a href="loginForm.do" class="site-btn" style="margin-left: 10px;">가입취소</a>
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
<script src="js/member/signUp.js"></script>