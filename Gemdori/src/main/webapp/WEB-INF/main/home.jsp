<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 슬라이더용 CSS & JS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/slider.css">
<script src="${pageContext.request.contextPath}/assets/js/slider.js"></script>

<section class="intro">
    <h1 class="title">Next-Level Gaming</h1>
    <p class="subtitle">최고의 게임 경험을 당신에게</p>
    <a href="${pageContext.request.contextPath}/games.do" class="btn-start">게임 보러가기 →</a>
</section>

<section class="trailer-slider">
    <div class="slider">
        <img src="${pageContext.request.contextPath}/assets/images/game1.jpg" alt="Game 1">
        <img src="${pageContext.request.contextPath}/assets/images/game2.jpg" alt="Game 2">
        <img src="${pageContext.request.contextPath}/assets/images/game3.jpg" alt="Game 3">
        <img src="${pageContext.request.contextPath}/assets/images/game4.jpg" alt="Game 4">
    </div>
</section>