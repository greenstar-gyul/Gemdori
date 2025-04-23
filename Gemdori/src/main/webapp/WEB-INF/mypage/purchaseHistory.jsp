<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="product spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-md-6 col-sm-8">
                <div class="category__sidebar" style="position: sticky; top: 80px;">
                    <div class="category__box">
                        <div class="section-title">
                            <h5>My Page</h5>
                        </div>
                        <ul class="category__list">
                            <li><a href="myPage.do">📱 내 정보</a></li>
                            <li><a href="purchaseHistory.do" class="active">📦 구매 내역</a></li>
                            <li><a href="library.do">📚 내 라이브러리</a></li>
                            <li><a href="#">📝 나의 리뷰</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="purchase-history">
                    <div class="section-title">
                        <h4>구매 내역</h4>
                    </div>

                    <c:choose>
                        <c:when test="${not empty purchaseList}">
                            <table class="purchase-table"> <%-- 이 클래스에 대한 스타일은 myPage.css에 있어야 함 --%>
                                <thead>
                                    <tr>
                                        <th>구매일시</th>
                                        <th>게임 타이틀</th>
                                        <th>결제 금액</th>
                                        <th>결제 수단</th>
                                        <th>상태</th>
                                        <th>작업</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${purchaseList}">
                                        <tr>
                                            <td>${fn:substring(item.purchaseDate, 0, 16)}</td>
                                            <td>
                                                <a href="gameDetail.do?gameCode=${item.gameCode}">
                                                    ${item.gameTitle}
                                                </a>
                                            </td>
                                            <td><fmt:formatNumber value="${item.price}" pattern="#,###" /> 원</td>
                                            <td>${item.paymentMethod}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${item.purchaseStatus == 1}">구매완료</c:when>
                                                    <c:otherwise>알 수 없음</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="gameDetail.do?gameCode=${item.gameCode}" class="btn btn-sm btn-info" title="게임 정보 보기"> <%-- 이 클래스들에 대한 스타일은 myPage.css에 있어야 함 --%>
                                                    <i class="fa fa-info-circle"></i> 보기
                                                </a>
                                                <a href="#" class="btn btn-sm btn-warning btn-write-review" data-game-code="${item.gameCode}" title="리뷰 작성하기">
                                                    <i class="fa fa-pencil"></i> 리뷰
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-message" style="text-align: center; padding: 40px; border: 1px dashed #ddd; border-radius: 5px;">
                                <p>아직 구매한 내역이 없습니다.</p>
                                <a href="gameList.do" class="primary-btn site-btn">스토어 둘러보기</a> <%-- 이 클래스들에 대한 스타일은 myPage.css 또는 다른 공통 CSS에 있어야 함 --%>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    // 배경 이미지 설정 (이 스크립트는 여기에 두거나 공통 JS 파일로 옮길 수 있음)
    var setBackground = document.querySelectorAll('.set-bg');
    setBackground.forEach(function(item) {
        var bg = item.getAttribute('data-setbg');
        if (bg) {
            item.style.backgroundImage = 'url(' + bg + ')';
        }
    });

    // 리뷰 쓰기 버튼 기능 (예시: 알림) (이 스크립트도 공통 JS로 옮기는 것이 좋음)
    document.querySelectorAll('.btn-write-review').forEach(function(btn) {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            var gameCode = this.getAttribute('data-game-code');
            alert('게임 코드 ' + gameCode + '에 대한 리뷰 작성 기능은 준비 중입니다.');
            // 실제 구현 시: location.href = 'writeReview.do?gameCode=' + gameCode;
        });
    });
</script>