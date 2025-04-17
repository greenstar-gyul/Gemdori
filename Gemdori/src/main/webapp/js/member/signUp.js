/**
 * signUp.js
 */
// 이메일 인증

let isEmailVerified = false; // 이메일 인증 체크
let isIdChecked = false; // 아이디 중복 확인 체크

document.addEventListener("DOMContentLoaded", function() {
	const verifyBtn = document.getElementById("check-username-btn");
	const emailInput = document.getElementById("userEmail");
	const codeInputWrap = document.getElementById("email-code-input-wrap");

	verifyBtn.addEventListener("click", function() {
		const email = emailInput.value.trim();

		if (!email) {
			alert("이메일을 입력해주세요.");
			emailInput.focus();
			return;
		}
		
		verifyBtn.disabled = true;
		verifyBtn.innerText = "전송 중...";

		setTimeout(() => {
			verifyBtn.disabled = false;
			verifyBtn.innerText = "인증 요청";
		}, 60000); // 60초 후 다시 활성화

		
		// 1. 서버로 인증번호 발송 요청 (예시 URL: sendEmailCode.do)
		fetch("sendEmailCode.do?email=" + encodeURIComponent(email))
			.then(response => response.text())
			.then(data => {
				// 입력칸이 이미 있다면 중복 생성 방지
				if (document.getElementById("email_code")) return;

				alert("인증번호가 전송되었습니다.");

				// 인증 코드 입력 UI 구성
				const wrapper = document.createElement("div");
				wrapper.className = "input__item input__item-with-btn";

				const input = document.createElement("input");
				input.type = "text";
				input.name = "code";
				input.id = "email_code";
				input.placeholder = "인증번호 입력";
				input.required = true;

				const icon = document.createElement("span");
				icon.className = "icon_key";

				const checkBtn = document.createElement("button");
				checkBtn.type = "button";
				checkBtn.className = "verify-btn";
				checkBtn.innerText = "인증 확인";
				

				// 인증 확인 클릭 시
				checkBtn.addEventListener("click", function() {
					const code = input.value.trim();
					console.log(code);

					if (!code) {
						alert("인증번호를 입력해주세요.");
						return;
					}

					// 서버로 인증번호 검증 요청
					fetch("verifyEmailCode.do", {
						method: "POST",
						headers: {
							"Content-Type": "application/x-www-form-urlencoded",
						},
						body: "email=" + encodeURIComponent(email) + "&code=" + encodeURIComponent(code)
					})
						.then(res => res.json())
						.then(result => {
							if (result.status === "success") {
								isEmailVerified = true;
								alert("이메일 인증이 완료되었습니다.");
								// 이메일 입력란 잠금
								emailInput.readOnly = true;

								// 인증 버튼 숨기기
								verifyBtn.style.display = "none";

								// 인증 완료 메시지 삽입
								const successMsg = document.createElement("div");
								successMsg.className = "success-msg";
								successMsg.textContent = "이메일 인증 완료";

								// 기존 입력창 지우고 메시지 삽입
								codeInputWrap.innerHTML = "";
								codeInputWrap.appendChild(successMsg);
							} else {
								alert("인증번호가 올바르지 않습니다.");
								input.value = "";
								input.focus();
							}
						});
				});

				// 조립 및 삽입
				wrapper.appendChild(input);
				wrapper.appendChild(icon);
				wrapper.appendChild(checkBtn);
				codeInputWrap.appendChild(wrapper);
			});
	});
});

// 아이디 소문자 영어, 숫자만 입력 허용
document.addEventListener("DOMContentLoaded", function () {
	const userIdInput = document.getElementById("userId");

	userIdInput.addEventListener("input", function () {
		const value = this.value;
		const valid = value.replace(/[^a-z0-9]/g, ""); // 소문자 영어 + 숫자만 허용
		if (value !== valid) {
			alert("아이디는 소문자 영어와 숫자만 입력할 수 있습니다.");
			this.value = valid;
			this.focus();
		}
	});
});

// 아이디 중복 확인
document.addEventListener("DOMContentLoaded", function() {
	const userIdInput = document.getElementById("userId");
	const checkBtn = document.getElementById("send-email-code-btn");
	const resultDiv = document.getElementById("id-check-result");

	let lastCheckedId = "";

	// 중복 확인 버튼 클릭 시 서버에 AJAX 요청
	checkBtn.addEventListener("click", function() {
		const userId = userIdInput.value.trim();

		if (userId.length < 6 || userId.length > 12) {
			alert("아이디는 6~12자 사이로 입력해주세요.");
			return;
		}

		fetch(`checkId.do?userId=${encodeURIComponent(userId)}`)
			.then(res => res.text())
			.then(data => {
				if (data === "usable") {
					isIdChecked = true;
					resultDiv.textContent = "사용 가능한 아이디입니다.";
					resultDiv.style.color = "green";
					checkBtn.style.display = "none";
					lastCheckedId = userId;
				} else {
					resultDiv.textContent = "이미 사용 중인 아이디입니다.";
					resultDiv.style.color = "red";
				}
			})
			.catch(() => {
				alert("서버 오류가 발생했습니다.");
			});
	});

	// 아이디 입력값 변경 시 확인 상태 초기화
	userIdInput.addEventListener("input", function() {
		if (userIdInput.value !== lastCheckedId) {
			resultDiv.textContent = "";
			checkBtn.style.display = "inline-block";
			isIdChecked = false; // 다시 확인하도록 설정
		}
	});
});

// 비밀번호 영어 입력 제한
document.addEventListener("DOMContentLoaded", function () {
	const pwInput = document.getElementById("userPw");

	pwInput.addEventListener("input", function () {
		const value = this.value;
		const valid = value.replace(/[^a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/g, ""); // 허용된 문자만 유지
		if (value !== valid) {
			alert("비밀번호는 영어 대소문자, 숫자, 특수문자만 사용할 수 있습니다.");
			this.value = valid;
			this.focus();
		}
	});
});

// 비밀번호 체크
function checkPasswordMatch() {
	const pw = document.getElementById("userPw");
	const cpw = document.getElementById("userCpw");

	if (pw.value && cpw.value && pw.value !== cpw.value) {
		alert("비밀번호가 일치하지 않습니다.");
		pw.value = "";
		cpw.value = "";
		pw.focus();
	}
}
// 이름 입력 시 숫자, 특수문자 입력 방지
document.addEventListener("DOMContentLoaded", function() {
	const nameFields = [
		document.querySelector("input[name='userFirstName']"),
		document.querySelector("input[name='userLastName']")
	];

	nameFields.forEach(field => {
		let isComposing = false;

		field.addEventListener("compositionstart", function() {
			isComposing = true; // 한글 조합 중
		});

		field.addEventListener("compositionend", function() {
			isComposing = false;
			validateName(this);
		});

		field.addEventListener("input", function() {
			if (!isComposing) {
				validateName(this);
			}
		});

		function validateName(inputEl) {
			const value = inputEl.value;
			if (/[^가-힣a-zA-Z]/.test(value)) {
				alert("이름에는 숫자나 특수문자 또는 자음, 모음만 입력할 수 없습니다.");
				inputEl.value = value.replace(/[^가-힣a-zA-Z]/g, '');
				inputEl.focus();
			}
		}
	});
});
// 전화번호 하이픈 기능
document.addEventListener("DOMContentLoaded", function() {
	const phoneInput = document.getElementById("userPhone");

	if (phoneInput) {
		// 1. 문자 또는 공백 입력 시 바로 제거
		phoneInput.addEventListener("input", function() {
			const val = this.value;

			// 문자 또는 공백 포함 시 경고 + 입력 제거
			if (/[^0-9]/.test(val)) {
				alert("전화번호는 숫자만 입력해야 합니다.");
				this.value = "";
				return;
			}
		});

		// 2. 입력 완료 시 포맷 변환 및 자리 수 확인
		phoneInput.addEventListener("blur", function() {
			const digits = this.value;

			if (digits.length === 0) return;

			if (digits.length !== 11) {
				this.value = "";
				setTimeout(() => alert("전화번호는 11자리 숫자로 입력해야 합니다."), 10);
				return;
			}

			// 자동 포맷 적용
			this.value = digits.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3");
		});
	}
});

// 날짜 데이터 변경
document.addEventListener('DOMContentLoaded', function() {
	flatpickr("#user_birthday", {
		dateFormat: "Y-m-d",
		locale: flatpickr.l10ns.ko,
		maxDate: "today", // ✅ 오늘까지 선택 가능 (미래일자는 선택 불가)
		minDate: "1900-01-01"
	});
});
// 공백 입력 방지
function preventWhitespace(input) {
	input.addEventListener("input", function() {
		if (/\s/.test(input.value)) {
			alert("띄어쓰기는 입력할 수 없습니다.");
			input.value = "";
			input.focus();
		}
	});
}
// 공백 입력 방지
document.addEventListener("DOMContentLoaded", function() {
	const targets = [
		"userId", "userPw", "userCpw",
		"userName", "userFirstName", "userLastName", "userPhone"
	];

	targets.forEach(id => {
		const input = document.getElementById(id);
		if (input) preventWhitespace(input);
	});
});

document.getElementById("signUpForm").addEventListener("submit", function(e) {
	const gender = document.getElementById("user_gender").value;
	const birthday = document.getElementById("user_birthday").value;

	// 생일 검사
	if (!birthday.trim()) {
		alert("생년월일을 입력해주세요.");
		e.preventDefault();
		return;
	}
	// 성별 검사
	if (!gender) {
		alert("성별을 선택해주세요.");
		e.preventDefault();
		return;
	}
	// 이메일 인증 확인
	if (!isEmailVerified) {
	    alert("이메일 인증을 완료해주세요.");
	    e.preventDefault();
	    return;
	}
	// 아이디 중복 확인 검사
	if (!isIdChecked) {
	    alert("아이디 중복 확인을 해주세요.");
	    e.preventDefault();
	    return;
	}

});