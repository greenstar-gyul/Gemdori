<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<style>
.profile-dropdown {
	position: relative;
	display: inline-block;
}

.profile-img {
	width: 30px;
	height: 30px;
	border-radius: 50%;
	object-fit: cover;
	cursor: pointer;
}

.dropdown-menu {
	display: none;
	position: absolute;
	right: 0;
	top: 40px;
	background-color: white;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
	border-radius: 5px;
	overflow: hidden;
	z-index: 1000;
	min-width: 120px;
}

.dropdown-menu li {
	list-style: none;
	border-bottom: 1px solid #eee;
}

.dropdown-menu li:last-child {
	border-bottom: none;
}

.dropdown-menu li a {
	display: block;
	padding: 10px 15px;
	color: #333;
	text-decoration: none;
	font-size: 14px;
}

.dropdown-menu li a:hover {
	background-color: #f2f2f2;
}

.cart-badge {
	position: absolute;
	top: -8px;
	right: -8px;
	background-color: #e53637;
	color: white;
	border-radius: 50%;
	width: 18px;
	height: 18px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 10px;
}
</style>

<%
com.gemdori.member.vo.UserFullVO loginUser = (com.gemdori.member.vo.UserFullVO) session.getAttribute("loginUser");

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
							<li class="active"><a href="./searchGames.do?keyword=">게임
									카테고리 <span class="arrow_carrot-down"></span>
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
					<!-- 로그인 / 비로그인 처리 -->
					<c:choose>
						<c:when test="${not empty sessionScope.loginUser}">
							<!-- 프로필 이미지 및 드롭다운 -->
							<div class="profile-dropdown">
								<img src="<c:url value='/img/${loginUser.userImage}'/>"
									alt="프로필 이미지" class="profile-img" onclick="toggleDropdown()" style="margin-right: 20px;width: 30px; height: 30px; border-radius: 50%; object-fit: cover;"/>
								<ul class="dropdown-menu" id="profileMenu">
									<li><a href="mypage.do">마이페이지</a></li>
									<li><a href="myInfo.do">회원정보수정</a></li>
									<li><a href="logout.do">로그아웃</a></li>
								</ul>
							</div>
						</c:when>
						<c:otherwise>
							<a href="${pageContext.request.contextPath}/loginForm.do"> <span
								class="icon_profile"></span>
							</a>
						</c:otherwise>
					</c:choose>
					<a href="#" class="search-switch"><span class="icon_search"></span></a>
					<a href="cartPage.do" style="position: relative;"><span
						class="icon_cart"></span> <span
						style="position: absolute; top: -8px; right: -8px; background-color: #e53637; color: white; border-radius: 50%; width: 18px; height: 18px; display: flex; align-items: center; justify-content: center; font-size: 10px;">2</span></a>
				</div>
			</div>
		</div>
		<div id="mobile-menu-wrap"></div>
	</div>
</header>
<script>
	const loginUser = {
		userCode : "${loginUser.userCode}",
		userId : "${loginUser.userId}",
		userName : "${loginUser.userName}",
		userEmail : "${loginUser.userEmail}",
		userUpdateTime : "${loginUser.updateTime}"
	};

	console.log("🔐 로그인 유저 정보:", loginUser);
	function toggleDropdown() {
		const menu = document.getElementById("profileMenu");
		menu.style.display = menu.style.display === "block" ? "none" : "block";
	}

	// 바깥 영역 클릭 시 닫기
	document.addEventListener("click", function(event) {
		const dropdown = document.querySelector(".profile-dropdown");
		const menu = document.getElementById("profileMenu");

		if (!dropdown.contains(event.target)) {
			menu.style.display = "none";
		}
	});
</script>