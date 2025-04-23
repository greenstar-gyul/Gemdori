<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<section class="product spad">
	<div class="container">
		<div class="row">
			<!-- Sidebar: 마이페이지 링크 -->
			<div class="col-lg-4 col-md-6 col-sm-8">
				<div class="category__sidebar" style="position: sticky; top: 80px;">
					<div class="category__box">
						<div class="section-title">
							<h5>My Page</h5>
						</div>
						<ul class="category__list">
							<li><a href="myPage.do">📱 내 정보</a></li>
							<li><a href="purchaseHistory.do">📦 구매 내역</a></li>
							<li><a href="library.do" class="active">📚 내 라이브러리</a></li>
							<li><a href="#">📝 나의 리뷰</a></li>
						</ul>
					</div>
				</div>
			</div>

			<!-- Main: 라이브러리 (구매한 게임 목록) -->
			<div class="col-lg-8">
				<div class="trending__product">
					<div class="section-title">
						<h4>내 게임 라이브러리</h4>
					</div>
					<div class="row">
						<c:choose>
							<c:when test="${not empty purchases}">
								<c:forEach var="purchase" items="${purchases}">
									<div class="col-lg-4 col-md-6 col-sm-6">
										<div class="product__item">
											<div class="product__item__pic set-bg"
												data-setbg="${purchase.thumbnailImage}">
												<div class="ep">${fn:substring(purchase.purchaseDate, 0, 10)}</div>
											</div>
											<div class="product__item__text">
												<h5>
													<a href="gameDetail.do?gameCode=${purchase.gameCode}">${purchase.gameTitle}</a>
												</h5>
												<div class="library-actions">
													<a href="#" class="btn-play">
														<i class="fa fa-download"></i> 설치하기
													</a>
													<a href="community.do?gameCode=${purchase.gameCode}" class="btn-community">
														<i class="fa fa-comments"></i> 커뮤니티
													</a>
													<a href="#" class="btn-delete">
														<i class="fa fa-trash"></i> 삭제하기
													</a>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div class="col-lg-12">
									<div class="empty-library">
										<p>아직 구매한 게임이 없습니다. 스토어에서 게임을 구매해보세요!</p>
										<a href="gameList.do" class="primary-btn">스토어 둘러보기</a>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<script>
	// 배경 이미지 설정
	var setBackground = document.querySelectorAll('.set-bg');
	setBackground.forEach(function(item) {
		var bg = item.getAttribute('data-setbg');
		item.style.backgroundImage = 'url(' + bg + ')';
	});
	
	// 기능이 없는 버튼을 위한 이벤트 핸들러
	document.querySelectorAll('.btn-play, .btn-delete').forEach(function(btn) {
		btn.addEventListener('click', function(e) {
			e.preventDefault();
			alert('이 기능은 아직 준비 중입니다.');
		});
	});
</script>
<link rel="stylesheet" href="css/gemdori/myPage.css" type="text/css">