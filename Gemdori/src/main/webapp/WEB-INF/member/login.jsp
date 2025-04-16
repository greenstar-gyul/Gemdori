<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/gemdori/loginForm.css" type="text/css">
<!-- Normal Breadcrumb Begin -->
<section class="normal-breadcrumb set-bg"
	data-setbg="img/normal-breadcrumb.jpg">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="normal__breadcrumb__text">
					<h2>Login</h2>
					<p>Welcome to the official Game site.</p>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Normal Breadcrumb End -->
<!-- Login Section Begin -->
<section class="login spad">
	<div class="container">
		<div class="row">
			<div class="col-lg-6">
				<div class="login__form">
					<h3>로그인</h3>
					<form action="#">
						<div class="input__item">
							<input type="text" name="user_login_name" placeholder="아이디"
								required> <span class="icon_profile"></span>
						</div>
						<div class="input__item">
							<input type="password" name="user_pw" placeholder="비밀번호" required>
							<span class="icon_lock"></span>
						</div>
						<button type="submit" class="site-btn">로그인</button>
					</form>
					<a href="#" class="forget_pass">비밀번호를 잊으셨나요?</a>
				</div>
			</div>
			<div class="col-lg-6">
				<div class="login__register">
					<h3>아직 회원이 아니신가요?</h3>
					<a href="signup.html" class="site-btn">회원가입</a>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Login Section End -->