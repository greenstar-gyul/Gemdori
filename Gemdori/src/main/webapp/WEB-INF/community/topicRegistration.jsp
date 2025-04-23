<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="blog spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-2">
            </div>
            <div class="col-lg-8" style="background-color: #203b57; padding:20px;">
                <form action="topicRegistration.do" method="post">
                	<input type="hidden" name="gameCode" value="${gameCode }">
                    <label>제목</label><br>
                    <input type="text" name="topicTitle" required style="width: 400px;"><br><br>

                    <label>내용</label><br>
                    <textarea name="topicContents" rows="10" cols="60" required></textarea><br><br>

                    <button type="submit">저장</button>

                    <c:if test="${not empty errorMessage}">
                        <p style="color:red;">${errorMessage}</p>
                    </c:if>
                </form>
            </div>
            <div class="col-lg-2">
            </div>
        </div>
    </div>
</section>