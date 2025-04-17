<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>비밀번호 찾기</title>
    <style>
        body { font-family: 'Noto Sans KR', sans-serif; padding: 30px; background: #f5f5f5; }
        form div { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input { width: 100%; padding: 8px; border-radius: 4px; border: 1px solid #ccc; }
        button { padding: 10px 20px; background: #e53637; color: white; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background: #b0272b; }
    </style>
</head>

<body>
    <h3>비밀번호 찾기</h3>
    <form action="findPassword.do" method="post">
        <div class="input__item">
            <input type="text" name="user_login_name" placeholder="아이디 입력" required>
        </div>
        <div class="input__item input__item--with-btn">
            <input type="email" name="user_email" placeholder="이메일 주소 입력" required>
            <button type="button" class="verify-btn" onclick="alert('인증 코드 전송')">인증 요청</button>
        </div>
        <div class="input__item">
            <input type="text" name="email_code" placeholder="인증 코드 입력" required>
        </div>
        <button type="submit" class="site-btn">비밀번호 찾기</button>
    </form>
</body>

</html>