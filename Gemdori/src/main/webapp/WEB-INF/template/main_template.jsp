<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Anime Template">
    <meta name="keywords" content="Anime, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Anime | Template</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;400;500;600;700;800;900&display=swap"
        rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="css/plyr.css" type="text/css">
    <link rel="stylesheet" href="css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="css/gemdori-style.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">

    <!-- Tiles Css Styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}<tiles:getAsString name='gemdoriCss'/>" />


    <style>
        .header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            /* 다른 요소 위로 올라오도록 */
            background-color: #121212;
            /* 배경 지정 (투명하면 내용 겹침) */
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            /* 아래 그림자 효과 */
        }

        body {
            padding-top: 40px;
            /* header 높이만큼 여백 줘야 콘텐츠가 안 가려짐 */
        }

        .category__sidebar {
            position: sticky;
            top: 80px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        /* 카테고리/즐겨찾기 박스 공통 */
        .category__box,
        .favorite__box {
            background: #111;
            /* 또는 #fff */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
        }

        /* 카테고리 */
        .category__list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .category__list li {
            margin-bottom: 10px;
        }

        .category__list li a {
            color: #fff;
            text-decoration: none;
        }

        .category__list li a:hover {
            color: #e53637;
        }

        /* 즐겨찾기 콘텐츠 */
        .favorite__item {
            text-align: center;
        }

        .favorite__item img {
            width: 100%;
            height: auto;
            border-radius: 8px;
            object-fit: cover;
            aspect-ratio: 4 / 3;
            transition: 0.3s;
        }

        .favorite__item img:hover {
            transform: scale(1.05);
        }

        .favorite__item p {
            color: #fff;
            font-size: 13px;
            margin-top: 5px;
            font-weight: 500;
        }
        .favorite__item p:hover {
            color: #e53637;
        }
        
        .hero__text p {
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 3;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
    </style>


</head>


<body>
    <!-- Page Preloder -->
    <!--<div id="preloder">
        <div class="loader"></div>
    </div>-->

    <!-- Header Section Begin -->
    <tiles:insertAttribute name="header"></tiles:insertAttribute>
    <!-- Header End -->
	
	<!-- Body Section Begin -->
	<tiles:insertAttribute name="body"></tiles:insertAttribute>
	<!-- Body Section End -->
	
    <!-- Footer Section Begin -->
	
    <!-- Footer Section End -->
	<tiles:insertAttribute name="footer"></tiles:insertAttribute>
    <!-- Search model Begin -->
    <div class="search-model">
        <div class="h-100 d-flex align-items-center justify-content-center">
            <div class="search-close-switch"><i class="icon_close"></i></div>
            <form class="search-model-form">
                <input type="text" id="search-input" placeholder="Search here.....">
            </form>
        </div>
    </div>
    <!-- Search model end -->

    <!-- Js Plugins -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="js/jquery.nice-select.min.js"></script>
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/player.js"></script>
<%--    <script src="js/jquery.nice-select.min.js"></script>--%>
    <script src="js/mixitup.min.js"></script>
    <script src="js/jquery.slicknav.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/main.js"></script>


</body>

</html>