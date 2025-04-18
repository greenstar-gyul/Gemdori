/**
 * loginForm.js
 */
document.addEventListener("DOMContentLoaded", function () {
    const userIdInput = document.querySelector("input[name='userId']");
    const userPwInput = document.querySelector("input[name='userPw']");
    const errorMsg = document.getElementById("loginErrorMsg");

    if (errorMsg) {
        userIdInput.addEventListener("input", () => errorMsg.style.display = "none");
        userPwInput.addEventListener("input", () => errorMsg.style.display = "none");
    }
});

function openFindPwPopup() {
    window.open(
        "findPassword.jsp",       // 👉 분리한 JSP 경로
        "비밀번호 찾기",            // 팝업 이름
        "width=400,height=350,scrollbars=no,resizable=no"
    );
}