<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>비밀번호 찾기</title>
    <link rel="stylesheet" href="css/gemdori/findPassword.css" type="text/css">
</head>
<body>
    <h3>비밀번호 찾기</h3>
    <form id="findPwForm" action="#" method="post">
    <!-- 아이디 입력 영역 -->
    <div class="input__item">
        <input type="text" name="userId" id="userId" placeholder="아이디 입력" required>
        <div id="idError" style="color:red; font-size:0.9em; margin-top:5px;"></div>
    </div>
    <button type="button" class="site-btn" id="checkIdBtn">아이디 확인</button>
    <!-- 인증 코드 입력 영역 (처음엔 숨김) -->
    <div id="codeArea" style="display:none;">
        <div class="input__item">
            <input type="text" name="email_code" id="emailCode" placeholder="인증 코드 입력" required>
        </div>
        <div class="button__wrap">
			<button type="button" class="site-btn" id="verifyCodeBtn">인증 확인</button>
		</div>
    </div>
    <!-- 비밀번호 표시 영역 -->
    <div id="pwResult" style="margin-top:10px; font-weight:bold;"></div>
</form>
<script src="js/member/findPassword.js"></script>
</body>
</html>