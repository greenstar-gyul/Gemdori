<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="css/gemdori/myInfo.css">

<section class="myinfo__section">
	<div class="myinfo__container">
		<h2 class="myinfo__title">회원탈퇴</h2>

		<p style="color: #e53637; font-weight: bold; margin-bottom: 20px;">
			정말로 회원탈퇴를 진행하시겠습니까?<br />
			탈퇴 시 계정 정보는 삭제되며 복구할 수 없습니다.
		</p>

		<form action="userDelete.do" method="post">
			<div class="myinfo__row">
				<div class="myinfo__label">비밀번호 확인</div>
				<div class="myinfo__value">
					<input type="password" name="userPw" required style="width: 100%;" placeholder="현재 비밀번호를 입력하세요" />
				</div>
			</div>

			<c:if test="${not empty error}">
				<div style="color: red; margin-bottom: 20px;">${error}</div>
			</c:if>

			<div class="myinfo__btn-group">
				<button class="myinfo__btn myinfo__btn--danger" type="submit">회원탈퇴</button>
				<button class="myinfo__btn" type="button" onclick="location.href='myInfo.do'">취소</button>
			</div>
		</form>
	</div>
</section>
