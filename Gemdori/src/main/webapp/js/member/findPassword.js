document.addEventListener("DOMContentLoaded", function () {
	const form = document.getElementById("findPwForm");
	const checkIdBtn = document.getElementById("checkIdBtn");
	const verifyCodeBtn = document.getElementById("verifyCodeBtn");

	const userIdInput = document.getElementById("userId");
	const idError = document.getElementById("idError");
	const codeArea = document.getElementById("codeArea");
	const codeInput = document.getElementById("emailCode");
	const pwResult = document.getElementById("pwResult");

	// 전송 상태 표시용 span 요소
	const loadingMsg = document.createElement("div");
	loadingMsg.id = "loadingMsg";
	loadingMsg.textContent = "전송 중 ...";
	loadingMsg.style.color = "#e53637";
	loadingMsg.style.marginTop = "5px";
	loadingMsg.style.fontSize = "0.9em";

	// 1. 아이디 확인 버튼
	checkIdBtn.addEventListener("click", function () {
		const userId = userIdInput.value.trim();
		if (!userId) {
			alert("아이디를 입력해주세요.");
			return;
		}

		// 전송 중 UI
		checkIdBtn.style.display = "none"; // 버튼 숨김
		userIdInput.parentElement.appendChild(loadingMsg); // 전송중 메시지 표시

		fetch(`findUserIdCheck.do?userId=${encodeURIComponent(userId)}`)
			.then(res => res.text())
			.then(result => {
				if (result === "sent") {
					idError.textContent = "";
					alert("인증 코드가 이메일로 전송되었습니다.");
					codeArea.style.display = "block";
					loadingMsg.remove(); // 전송 중 메시지 제거
				} else {
					idError.textContent = "존재하지 않는 아이디입니다.";
					codeArea.style.display = "none";
					checkIdBtn.style.display = "inline-block"; // 다시 보이게
					loadingMsg.remove(); // 전송 중 메시지 제거
				}
			})
			.catch(() => {
				alert("서버 오류가 발생했습니다.");
				checkIdBtn.style.display = "inline-block"; // 다시 보이게
				loadingMsg.remove();
			});
	});

	// 아이디 입력 시 오류 메시지 제거 + 초기화
	userIdInput.addEventListener("input", function () {
		idError.textContent = "";
		codeArea.style.display = "none";
		codeInput.value = "";
		if (!checkIdBtn.style.display || checkIdBtn.style.display === "none") {
			checkIdBtn.style.display = "inline-block";
		}
		const msg = document.getElementById("loadingMsg");
		if (msg) msg.remove();
	});

	// 2. 인증 확인 버튼
	verifyCodeBtn.addEventListener("click", function () {
		const inputCode = codeInput.value.trim();
		if (!inputCode) {
			alert("인증 코드를 입력해주세요.");
			return;
		}

		fetch("verifyEmailCode.do", {
			method: "POST",
			headers: {
				"Content-Type": "application/x-www-form-urlencoded"
			},
			body: "code=" + encodeURIComponent(inputCode)
		})
			.then(res => res.json())
			.then(data => {
				if (data.status === "success") {
					alert("인증이 완료되었습니다. 임시 비밀번호를 발급합니다.");
					// 임시 비밀번호 요청
					fetch("recombinationPw.do")
						.then(res => res.text())
						.then(tempPw => {
							if (tempPw === "error" || tempPw === "unauthorized") {
								alert("임시 비밀번호 생성에 실패했습니다.");
							} else {
								pwResult.innerHTML = `<span style="color:#e53637">임시 비밀번호 : <strong>${tempPw}</strong></span>`;
								codeArea.style.display = "none";
								userIdInput.style.display = "none";
								checkIdBtn.style.display = "none";
							}
						});
				} else {
					alert("인증 코드가 올바르지 않습니다.");
				}
			});
	});
});
