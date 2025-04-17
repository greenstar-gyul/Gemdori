<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<header class="header">
        <div class="container">
            <div class="row">
                <div class="col-lg-2">
                    <div class="header__logo">
                        <a href="./index.html" >
                            <img src="img/logo.png" alt="" >
                        </a>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="header__nav">
                        <nav class="header__menu mobile-menu">
                            <ul>
                                <li class="active"><a href="./index.html">Home</a></li>
                                <li><a href="./blog.html">Library</a></li>

                                <li><a href="./categories.html">Categories <span class="arrow_carrot-down"></span></a>
                                    <ul class="dropdown">
                                        <li><a href="./categories.html">Categories</a></li>
                                        <li><a href="./anime-details.html">Anime Details</a></li>
                                        <li><a href="./anime-watching.html">Anime Watching</a></li>
                                        <li><a href="./blog-details.html">Blog Details</a></li>
                                        <li><a href="./signup.html">Sign Up</a></li>
                                        <li><a href="./login.html">Login</a></li>
                                    </ul>
                                </li>
                                <li><a href="./blog.html">Community</a></li>
                                <li><a href="#">My Page</a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="header__right">
                        <c:choose>
					    <c:when test="${not empty sessionScope.loginUser}">
					      <!-- 로그인된 상태: 마이페이지로 이동 -->
					      <a href="${pageContext.request.contextPath}/user/mypage.do">
					        <span class="icon_profile"></span>
					      </a>
					    </c:when>
					    <c:otherwise>
					      <!-- 비로그인 상태: 로그인 페이지로 이동 -->
					      <a href="${pageContext.request.contextPath}/user/login.do">
					        <span class="icon_profile"></span>
					      </a>
					    </c:otherwise>
					  </c:choose>
                        <a href="${pageContext.request.contextPath}/cart.do">
				            <span class="icon_cart"></span>
				        </a>
                        <a href="#" class="search-switch"><span class="icon_search"></span></a>
					  
                    </div>
                </div>
            </div>
            <div id="mobile-menu-wrap"></div>
        </div>
    </header>