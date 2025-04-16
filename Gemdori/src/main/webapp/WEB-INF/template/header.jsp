<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<header class="header">
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
								<li class="active"><a href="./categories.html">게임 카테고리
										<span class="arrow_carrot-down"></span>
								</a>
									<ul class="dropdown">
										<li><a href="./categories.html">전체 게임</a></li>
										<li><a href="./categories.html?genre=action">액션</a></li>
										<li><a href="./categories.html?genre=rpg">RPG</a></li>
										<li><a href="./categories.html?genre=strategy">전략</a></li>
										<li><a href="./categories.html?genre=adventure">어드벤처</a></li>
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
						<a href="#" class="search-switch"><span class="icon_search"></span></a>
						<a href="./mypage.html"><span class="icon_profile"></span></a> <a
							href="cartPage.do" style="position: relative;"><span class="icon_cart"></span><span
							style="position: absolute; top: -8px; right: -8px; background-color: #e53637; color: white; border-radius: 50%; width: 18px; height: 18px; display: flex; align-items: center; justify-content: center; font-size: 10px;">2</span></a>
					</div>
				</div>
			</div>
			<div id="mobile-menu-wrap"></div>
		</div>
    </header>