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
    
    <!-- 글쓰기 버튼 -->
    <div class="row mb-4">
    <div class="col-lg-12 text-right">
        <a href="community/post.jsp" class="btn btn-primary">글쓰기</a>
       </div>
     </div>
    
    
    <!--  

          
          2. 글쓰기 창을 만들기 (       )에서
          3. 글을 저장하는 버튼도 만들기
          3-1 PostControl.java 만들기
          3-2 community/post.tiles로 연결
          3-4 글 등록 버튼을 눌렀을 경우에 gemdori_topic_tbl에 저장이 되게 하기
          3-5 저장이 된 경우에 글 목록으로 돌아가기
           4. 글의 목록에 반영이 되도록 만들기 (gemdori_topic_tbl)
     -->

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
