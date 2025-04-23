<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<link rel="stylesheet" href="css/gemdori/myInfo.css">

<section class="myinfo__section">
	<div class="myinfo__container">
		<h2 class="myinfo__title">나의 프로필 정보</h2>

		<img src="<c:url value='/img/${user.userImage}'/>" alt="프로필 이미지"
			class="myinfo__profile-img" />

		<div class="myinfo__row">
			<div class="myinfo__label">이름</div>
			<div class="myinfo__value">${user.userLastName}${user.userFirstName}</div>
		</div>

		<div class="myinfo__row">
			<div class="myinfo__label">닉네임</div>
			<div class="myinfo__value">${user.userName}</div>
		</div>

		<div class="myinfo__row">
			<div class="myinfo__label">이메일</div>
			<div class="myinfo__value">${user.userEmail}</div>
		</div>

		<div class="myinfo__row">
			<div class="myinfo__label">전화번호</div>
			<div class="myinfo__value">${user.userPhone}</div>
		</div>

		<div class="myinfo__row">
			<div class="myinfo__label">생일</div>
			<div class="myinfo__value">
				<c:if test="${not empty user.userBirthday}">
					<fmt:formatDate value="${user.userBirthday}" pattern="yyyy-MM-dd" />
				</c:if>
			</div>
		</div>

		<div class="myinfo__row">
			<div class="myinfo__label">성별</div>
			<div class="myinfo__value">
				<c:choose>
					<c:when test="${user.userGender eq 'M'}">남자</c:when>
					<c:when test="${user.userGender eq 'F'}">여자</c:when>
					<c:otherwise>성별 정보 없음</c:otherwise>
				</c:choose>
			</div>
		</div>

		<div class="myinfo__row">
			<div class="myinfo__label">프로필 정보</div>
			<div class="myinfo__value">
				<c:choose>
      				<c:when test="${empty user.userIntro}">
        				안녕하세요. ${user.userName}입니다.
      				</c:when>
      				<c:otherwise>
        				${user.userIntro}
      				</c:otherwise>
    			</c:choose>
    		</div>
		</div>

		<div class="myinfo__row">
			<div class="myinfo__label">프로필 마지막 수정일자</div>
			<div class="myinfo__value">
				<c:if test="${not empty user.updateTime}">
					<fmt:formatDate value="${user.updateTime}"
						pattern="yyyy-MM-dd HH:mm" />
				</c:if>
			</div>
		</div>

		<div class="myinfo__row">
			<div class="myinfo__label">이전 마지막 로그인 일자</div>
			<div class="myinfo__value">
				<c:if test="${not empty user.lastLoginDate}">
					<fmt:formatDate value="${user.lastLoginDate}"
						pattern="yyyy-MM-dd HH:mm" />
				</c:if>
			</div>
		</div>

		<div class="myinfo__row">
			<div class="myinfo__label">마지막 비밀번호 변경일자</div>
			<div class="myinfo__value">
				<c:if test="${not empty user.securityUpdateTime}">
					<fmt:formatDate value="${user.securityUpdateTime}"
						pattern="yyyy-MM-dd HH:mm" />
				</c:if>
			</div>
		</div>

		<div class="myinfo__btn-group">
			<button class="myinfo__btn" onclick="location.href='updateProfileForm.do'">프로필
				수정</button>
			<button class="myinfo__btn"
				onclick="location.href='updatePasswordForm.do'">비밀번호 수정</button>
			<button class="myinfo__btn myinfo__btn--danger"
				onclick="location.href='userDeleteForm.do'">회원탈퇴</button>
		</div>
	</div>
</section>
<script src="js/member/myInfo.js"></script>