<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        font-size: 16px;
        font-family: sans-serif;
    }

    th {
        background-color: #222;
        color: white;
        padding: 10px;
        border: 1px solid #ccc;
        text-align: left;
    }

    td {
        padding: 10px;
        border: 1px solid #ccc;
        background-color: white;
        color: #333;
    }

    tr:hover td {
        background-color: #f2f2f2;
    }

    .write-button {
        text-align: right;
        margin: 20px 0;
    }

    .write-button a {
        background-color: #007bff;
        color: white;
        padding: 8px 14px;
        text-decoration: none;
        border-radius: 4px;
    }

    .write-button a:hover {
        background-color: #0056b3;
    }
</style>

<!-- Normal Breadcrumb Begin -->
<section class="normal-breadcrumb set-bg" data-setbg="img/gemdoribg.png">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="normal__breadcrumb__text">
                    <h2>커뮤니티</h2>
                    <p>겜도리 공식 커뮤니티</p>
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
            <!-- 글쓰기 버튼 -->
            <div class="col-lg-12 text-right">
                <a href="topicForm.do?gameCode=${gameCode}" class="btn btn-primary">글쓰기</a>
            </div>
            <div class="col-lg-12">
                <!-- 테이블 시작 -->
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>제목</th>
                            <th>내용</th>
                            <th>작성자</th>
                            <th>작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 반복문을 통해 게시글 목록 출력 -->
                        <c:forEach var="post" items="${topicList}">
  							<a href="topicDetail.do?topicCode=${post.topicCode}">
                                <tr>
                                    <td>${post.topicTitle}</td>
                                    <td>${post.topicContents}</td>
                                    <td>${post.userCode}</td>
                                    <td>${post.writeDate}</td>
                                </tr>
                            </a>
                        </c:forEach>
                    </tbody>
                </table>
                <!-- 테이블 끝 -->
            </div>
        </div>
    </div>
</section>
<!-- Blog Section End -->

