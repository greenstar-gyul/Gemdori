/**
 * updateProfileForm.js
 */


document.addEventListener("DOMContentLoaded", function() {
	// 생일 설정
	const dateInput = document.getElementById("userBirthday");
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
});