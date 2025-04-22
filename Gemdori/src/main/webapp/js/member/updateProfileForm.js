/**
 * updateProfileForm.js
 */


document.addEventListener("DOMContentLoaded", function() {
	// 생일 설정
	const dateInput = document.getElementById("userBirthday");

	// 오늘 날짜를 yyyy-MM-dd 형식으로 만들기
	const today = new Date().toISOString().split("T")[0];
	dateInput.max = today; // 최대 날짜 설정

	const displaySpan = document.getElementById("displayBirthday");
	dateInput.addEventListener("change", function() {
		displaySpan.textContent = this.value;
	});



	// 이미지 업로드 미리보기 기능
	const imageInput = document.querySelector('input[name="userImage"]');
	const previewImg = document.querySelector('.myinfo__profile-img');

	imageInput.addEventListener('change', function() {
		const file = this.files[0];
		if (file) {
			const reader = new FileReader();
			reader.onload = function(e) {
				previewImg.src = e.target.result;
			};
			reader.readAsDataURL(file);
		}
	});
	// 프로필 글자수 카운터
	const introTextarea = document.querySelector("textarea[name='userIntro']");
	const introCount = document.getElementById("introCount");
	if (introTextarea && introCount) {
		introTextarea.addEventListener("input", function() {
			introCount.textContent = `${this.value.length} / 100자`;
		});
		// 초기값
		introCount.textContent = `${introTextarea.value.length} / 100자`;
	}
});