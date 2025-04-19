<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>임시 세션 설정</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #1d1e39;
        color: white;
        margin: 0;
        padding: 20px;
    }
    .container {
        max-width: 600px;
        margin: 50px auto;
        background-color: #0b0c2a;
        padding: 30px;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0,0,0,0.3);
    }
    h2 {
        color: #e53637;
        margin-bottom: 20px;
    }
    form {
        margin-top: 20px;
    }
    label {
        display: block;
        margin-bottom: 8px;
    }
    input[type="text"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        background-color: #1d1e39;
        border: 1px solid rgba(255,255,255,0.2);
        color: white;
        border-radius: 3px;
    }
    button {
        background-color: #e53637;
        color: white;
        border: none;
        padding: 12px 20px;
        border-radius: 3px;
        cursor: pointer;
        font-size: 16px;
    }
    button:hover {
        background-color: #d82a2b;
    }
    .message {
        margin-top: 20px;
        padding: 10px;
        background-color: rgba(229, 54, 55, 0.2);
        border-radius: 3px;
    }
</style>
</head>
<body>
    <div class="container">
        <h2>임시 세션 설정</h2>
        <p>장바구니 테스트를 위한 임시 사용자 코드를 설정합니다.</p>
        
        <% if(request.getAttribute("message") != null) { %>
            <div class="message">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>
        
        <form action="tempSession.do" method="post">
            <label for="userCode">사용자 코드:</label>
            <input type="text" id="userCode" name="userCode" placeholder="예: user001" value="U2">
            
            <button type="submit">세션에 저장하고 장바구니로 이동</button>
        </form>
    </div>
</body>
</html>