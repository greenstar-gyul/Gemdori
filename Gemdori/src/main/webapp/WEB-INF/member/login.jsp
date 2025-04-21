<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
					<form action="login.do" method="post">
						<div class="input__item">
							<input type="text" name="userId" placeholder="아이디"
								required> <span class="icon_profile"></span>
						</div>
						<div class="input__item">
							<input type="password" name="userPw" placeholder="비밀번호" required>
							<span class="icon_lock"></span>
						</div>
						<c:if test="${not empty msg}">
    						<div id="loginErrorMsg" style="color: red; font-size: 0.9em; margin-top: 5px;">
        					${msg}
    						</div>
						</c:if>
						<button type="submit" class="site-btn">로그인</button>
					</form>
					<a href="#" class="forget_pass" onclick="window.open('findPassword.do', 'pwPopup', 'width=500,height=400'); return false;">비밀번호를 잊으셨나요?</a>
				</div>
			</div>
			<div class="col-lg-6">
				<div class="login__register">
					<h3>아직 회원이 아니신가요?</h3>
					<a href="signForm.do" class="site-btn">회원가입</a>
				</div>
			</div>
		</div>
	</div>
</section>
<c:if test="${param.message eq 'changeSuccess'}">
  <script>
    alert("비밀번호가 성공적으로 변경되었습니다.\n다시 로그인해 주세요.");
    if (window.history.replaceState) {
        const url = new URL(window.location);
        url.searchParams.delete("message");
        window.history.replaceState({}, document.title, url.pathname);
      }
  </script>
</c:if>
<!-- Login Section End -->
<script src="js/member/loginForm.js"></script>
<link rel="stylesheet" href="css/gemdori/loginForm.css" type="text/css">