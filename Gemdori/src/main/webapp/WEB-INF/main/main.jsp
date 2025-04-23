<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Hero Section Begin -->


<section class="hero">
    <div class="container">
        <div class="hero__slider owl-carousel">
            <c:forEach var="game" items="${latestGameList}">
            	<a href="gameDetails.do?gameCode=${game.gameCode}" style="display: block;">
                <div class="hero__items set-bg" data-setbg="${game.gameMainImage}" style="height: 524.5px;">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="hero__text" style="background-color: RGBA(0, 0, 0, 0.5); padding: 5px">
                                <h2>${game.gameTitle}</h2>
                                <p>${game.gameDesc}</p>
                                <%--<a href="gameDetails.do?gameCode=${game.gameCode}"><span>Play Game</span> <i class="fa fa-angle-right"></i></a>--%>
                            </div>
                        </div>
                    </div>
                </div>
                </a>
            </c:forEach>
        </div>
    </div>
</section>
<!-- Hero Section End -->


<!-- Product Section Begin -->
<section class="product spad">
    <div class="container">
        <div class="row">

            <!-- ì¬ì´ë ìì­-->
            <!-- 사이드바 있던 영역 -->
            <!-- ì¬ì´ë ìì­ ë -->
            <!-- 최고 인기게임 -->
            <div class="col-lg-12">
                <div class="trending__product" style="margin-top: 20px;">
                    <div class="row">
                        <div class="col-lg-8 col-md-8 col-sm-8">
                            <div class="section-title">
                                <h4>겜도리 최고 인기 게임</h4>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <div class="btn__all">
                                <a href="searchGames.do" class="primary-btn">더보기<span class="arrow_right"></span></a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <c:forEach var="game" items="${bestGameList}">
                            <c:set var="appid" value="${fn:substring(game.gameCode, 1, fn:length(game.gameCode))}" />
                            <c:set var="fallbackImg" value="${fn:escapeXml(game.gameMainImage)}" />
                            <div class="col-lg-3 col-md-6 col-sm-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg"
                                         data-setbg="https://cdn.cloudflare.steamstatic.com/steam/apps/${appid}/library_600x900.jpg"
                                         data-fallback="${fallbackImg}">
                                            <%-- 필요 없으면 ep/comment/view는 생략 가능 --%>
                                    </div>
                                    <div class="product__item__text">
                                        <ul>
                                            <c:forEach var="genre" items="${fn:split(game.gameGenre, ',')}">
                                                <li>${genre}</li>
                                            </c:forEach>
                                        </ul>
                                        <h5><a href="gameDetails.do?gameCode=${game.gameCode }">${game.gameTitle}</a></h5>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="popular__product">
                    <div class="row">
                        <div class="col-lg-8 col-md-8 col-sm-8">
                            <div class="section-title">
                                <h4>겜도리 추천 게임</h4>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <div class="btn__all">
                                <a href="searchGames.do" class="primary-btn">더보기<span class="arrow_right"></span></a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <c:forEach var="game" items="${popList}">
                            <c:set var="appid" value="${fn:substring(game.gameCode, 1, fn:length(game.gameCode))}" />
                            <c:set var="fallbackImg" value="${fn:escapeXml(game.gameMainImage)}" />
                            <div class="col-lg-3 col-md-6 col-sm-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg"
                                         data-setbg="https://cdn.cloudflare.steamstatic.com/steam/apps/${appid}/library_600x900.jpg"
                                         data-fallback="${fallbackImg}">
                                            <%-- 필요 없으면 ep/comment/view는 생략 가능 --%>
                                    </div>
                                    <div class="product__item__text">
                                        <ul>
                                            <c:forEach var="genre" items="${fn:split(game.gameGenre, ',')}">
                                                <li>${genre}</li>
                                            </c:forEach>
                                        </ul>
                                        <h5><a href="gameDetails.do?gameCode=${game.gameCode }">${game.gameTitle}</a></h5>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="recent__product">
                    <div class="row">
                        <div class="col-lg-8 col-md-8 col-sm-8">
                            <div class="section-title">
                                <h4>최근 추가된 게임</h4>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4">
                            <div class="btn__all">
                                <a href="searchGames.do" class="primary-btn">더보기<span class="arrow_right"></span></a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 최근 게임 반복문 -->
                    <div class="row">
                        <c:forEach var="game" items="${latestGameList}">
                            <c:set var="appid" value="${fn:substring(game.gameCode, 1, fn:length(game.gameCode))}" />
                            <c:set var="fallbackImg" value="${fn:escapeXml(game.gameMainImage)}" />
						    <div class="col-lg-3 col-md-6 col-sm-6">
						        <div class="product__item">
						            <div class="product__item__pic set-bg"
                                         data-setbg="https://cdn.cloudflare.steamstatic.com/steam/apps/${appid}/library_600x900.jpg"
                                         data-fallback="${fallbackImg}">
						                <%-- 필요 없으면 ep/comment/view는 생략 가능 --%>
						            </div>
						            <div class="product__item__text">
						                <ul>
						                    <c:forEach var="genre" items="${fn:split(game.gameGenre, ',')}">
						                        <li>${genre}</li>
						                    </c:forEach>
						                </ul>
						                <h5><a href="gameDetails.do?gameCode=${game.gameCode }">${game.gameTitle}</a></h5>
						            </div>
						        </div>
						    </div>
						</c:forEach>
                    </div>
                    
                </div>
                
            </div>


        </div>
    </div>
</section>
<!-- Product Section End -->
