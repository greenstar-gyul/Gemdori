/**
 * updatePasswordForm.js
 */
document.addEventListener("DOMContentLoaded", function () {
  const pwInput = document.getElementById("newPassword");
  const errorDiv = document.getElementById("clientError");

  pwInput.addEventListener("input", function () {
    const value = this.value;
    const valid = value.replace(/[^a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/g, "");

    if (value !== valid) {
      errorDiv.textContent = "비밀번호는 영어 대소문자, 숫자, 특수문자만 사용할 수 있습니다.";
      this.value = valid;
      this.focus();
    } else {
      errorDiv.textContent = ""; // 정상 입력 시 메시지 제거
    }
  });
});