<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!-- Normal Breadcrumb Begin -->
    <section class="normal-breadcrumb set-bg" data-setbg="img/normal-breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="normal__breadcrumb__text">
                        <h2>Our Blog</h2>
                        <p>Welcome to the official Anime blog.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Normal Breadcrumb End -->

    <!-- Blog Section Begin -->
    <section class="blog spad">
        <div class="container">
            <div class="row">
                <!-- 왼쪽 영역 -->
                <div class="col-lg-6">
                    <div class="row">
                                <div class="blog__item set-bg" data-setbg="${post.image}">
                                <img alt="" src="${post.image}">
                                    <div class="blog__item__text">
                                        <p><span class="icon_calendar"></span> ${post.date}</p>
                                        <h4><a href="#">${post.title}</a></h4>
                                    </div>
                            </div>
                    </div>
                </div>
                <!-- 오른쪽 영역 -->
                <div class="col-lg-6">
                    <div class="row">
                                <div class="blog__item set-bg" data-setbg="${post.image}">
                                <img alt="" src="${post.image}">
                                    <div class="blog__item__text">
                                        <p><span class="icon_calendar"></span> ${post.date}</p>
                                        <h4><a href="#">${post.title}</a></h4>
                                    </div>
                            </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Section End -->
