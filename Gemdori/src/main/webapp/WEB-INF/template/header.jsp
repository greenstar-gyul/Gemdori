<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%
    com.gemdori.member.vo.UserFullVO loginUser = 
        (com.gemdori.member.vo.UserFullVO) session.getAttribute("loginUser");

    String userCode = loginUser != null ? loginUser.getUserCode() : "";
    String userId = loginUser != null ? loginUser.getUserId() : "";
    String userName = loginUser != null ? loginUser.getUserName() : "";
    String email = loginUser != null ? loginUser.getUserEmail() : "";
%>
<header class="header" style="background: black">
  <div class="container">
			<div class="row">
				<div class="col-lg-2">
					<div class="header__logo">
						<a href="main.do"> <img src="img/logo.png" alt="">
						</a>
					</div>
				</div>
				<div class="col-lg-8">
					<div class="header__nav">
						<nav class="header__menu mobile-menu">
							<ul>
								<li><a href="main.do">홈</a></li>
								<li class="active"><a href="./searchGames.do?keyword=">게임 카테고리
										<span class="arrow_carrot-down"></span>
								</a>
									<ul class="dropdown">
										<li><a href="./searchGames.do?keyword=">전체 게임</a></li>
										<li><a href="./searchGames.do?keyword=&genre=action">액션</a></li>
										<li><a href="./searchGames.do?keyword=&genre=rpg">RPG</a></li>
										<li><a href="./searchGames.do?keyword=&genre=strategy">전략</a></li>
										<li><a href="./searchGames.do?keyword=&genre=adventure">어드벤처</a></li>
										<li><a href="./signup.html">회원가입</a></li>
										<li><a href="./login.html">로그인</a></li>
									</ul></li>
								<li><a href="./blog.html">뉴스 및 공지</a></li>
								<li><a href="#">고객센터</a></li>
							</ul>
						</nav>
					</div>
				</div>
				<div class="col-lg-2">
					<div class="header__right">
						 <c:choose>
					    <c:when test="${not empty sessionScope.loginUser}">
					      <!-- 로그인된 상태: 마이페이지로 이동 -->
					      <a href="${pageContext.request.contextPath}/mypage.do">
					        <span class="icon_profile"></span>
					      </a>
					    </c:when>
					    <c:otherwise>
					      <!-- 비로그인 상태: 로그인 페이지로 이동 -->
					      <a href="${pageContext.request.contextPath}/login.do">
					        <span class="icon_profile"></span>
					      </a>
					    </c:otherwise>
					  </c:choose>
            <a href="#" class="search-switch"><span class="icon_search"></span></a>
            <a href="cartPage.do" style="position: relative;"><span class="icon_cart"></span>
            <span style="position: absolute; top: -8px; right: -8px; background-color: #e53637; color: white; border-radius: 50%; width: 18px; height: 18px; display: flex; align-items: center; justify-content: center; font-size: 10px;">2</span></a>
					<c:if test="${not empty sessionScope.loginUser}">
        				<a href="logout.do" title="로그아웃" style="margin-left: 10px;">
            				임시 로그아웃
						</a>
    				</c:if>
					</div>
				</div>
			</div>
			<div id="mobile-menu-wrap"></div>
		</div>
</header>
<script>
    const loginUser = {
        userCode: "<%= userCode %>",
        userId: "<%= userId %>",
        userName: "<%= userName %>",
        userEmail: "<%= email %>"
    };

    console.log("🔐 로그인 유저 정보:", loginUser);
</script>