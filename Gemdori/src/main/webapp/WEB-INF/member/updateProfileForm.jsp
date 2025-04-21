<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="css/gemdori/myInfo.css">

<section class="myinfo__section">
	<div class="myinfo__container">
		<h2 class="myinfo__title">프로필 정보 수정</h2>

		<form action="updateProfile.do" method="post"
			enctype="multipart/form-data">
			<div class="myinfo__row">
				<div class="myinfo__label">프로필 이미지</div>
				<div class="myinfo__value">
					<input type="file" name="userImage" accept="image/*"> <img
						src="<c:url value='/img/${user.userImage}'/>"
						class="myinfo__profile-img" alt="현재 이미지">
				</div>
			</div>

			<div class="myinfo__row">
				<div class="myinfo__label">닉네임</div>
				<div class="myinfo__value">
					<input type="text" name="userName" value="${user.userName}"
						required>
				</div>
			</div>

			<div class="myinfo__row">
				<div class="myinfo__label">성별</div>
				<div class="myinfo__value">
					<label><input type="radio" name="userGender" value="M"
						${user.userGender eq 'M' ? 'checked' : ''}> 남자</label> <label
						style="margin-left: 20px;"><input type="radio"
						name="userGender" value="F"
						${user.userGender eq 'F' ? 'checked' : ''}> 여자</label>
				</div>
			</div>

			<div class="myinfo__row">
				<div class="myinfo__label" for="userBirthday">생일</div>
				<div class="myinfo__value" onclick="document.getElementById('userBirthday').showPicker()"
					style="cursor: pointer;">
					<span id="displayBirthday"><fmt:formatDate value="${user.userBirthday}" pattern="yyyy-MM-dd" /></span> <input type="date"
						id="userBirthday" name="userBirthday"
						style="opacity: 0; position: absolute;" />
				</div>
			</div>

			<div class="myinfo__row">
				<div class="myinfo__label">프로필 정보</div>
				<div class="myinfo__value">
					<textarea name="userIntro" rows="4" style="width: 100%;">${user.userIntro}</textarea>
				</div>
			</div>

			<div class="myinfo__btn-group">
				<button class="myinfo__btn" type="submit">수정 완료</button>
				<button class="myinfo__btn myinfo__btn--danger" type="button"
					onclick="location.href='myInfo.do'">취소</button>
			</div>
		</form>
	</div>
</section>
<script src="js/member/updateProfileForm.js"></script>