/**
 *  myInfo.js
 */
// URL에 ?update=success 가 있을 경우 alert 표시
document.addEventListener("DOMContentLoaded", function () {
  const urlParams = new URLSearchParams(window.location.search);
  if (urlParams.get("update") === "success") {
    alert("프로필 정보가 성공적으로 수정되었습니다!");
	history.replaceState(null, "", location.pathname); // 쿼리 파라미터 제거
  }
});