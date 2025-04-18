<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<body>

<h2>글쓰기</h2>

<form action="topicRegistration.do" method="post">
    <label>제목</label><br>
    <input type="text" name="topicTitle" required style="width: 400px;"><br><br>

    <label>내용</label><br>
    <textarea name="topicContents" rows="10" cols="60" required></textarea><br><br>

    <button type="submit">저장</button>

    <c:if test="${not empty errorMessage}">
        <p style="color:red;">${errorMessage}</p>
    </c:if>
</form>

</body>
</html>
