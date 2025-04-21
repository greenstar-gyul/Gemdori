<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="css/gemdori/myInfo.css">

<section class="myinfo__section">
	<div class="myinfo__container">
		<h2 class="myinfo__title">비밀번호 변경</h2>

		<c:if test="${not empty error}">
			<div style="color: red; margin-bottom: 20px;">${error}</div>
		</c:if>

		<form action="updatePassword.do" method="post">
			<div class="myinfo__row">
				<div class="myinfo__label">기존 비밀번호</div>
				<div class="myinfo__value">
					<input type="password" name="currentPassword" required
						style="width: 100%;" />
				</div>
			</div>

			<div class="myinfo__row">
				<div class="myinfo__label">새 비밀번호</div>
				<div class="myinfo__value">
					<input type="password" name="newPassword" id="newPassword" required
						minlength="8" maxlength="16" style="width: 100%;"
						placeholder="8~16자, 영문 소문자/숫자 조합" />
				</div>
			</div>

			<div class="myinfo__row">
				<div class="myinfo__label">비밀번호 확인</div>
				<div class="myinfo__value">
					<input type="password" name="confirmPassword" id="confirmPassword"
						required minlength="8" maxlength="16" style="width: 100%;"
						placeholder="동일한 비밀번호를 입력해주세요" />
				</div>
			</div>
		</form>
	</div>
</section>
