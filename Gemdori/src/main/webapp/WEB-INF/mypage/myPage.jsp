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
							<li><a href="myPage.do" class="active">📱 내 정보</a></li>
							<li><a href="purchaseHistory.do">📦 구매 내역</a></li>
							<li><a href="library.do">📚 내 라이브러리</a></li>
							<li><a href="#">📝 나의 리뷰</a></li>
						</ul>
					</div>
				</div>
			</div>


			<!-- Main: 최근 활동 내역 -->
			<div class="col-lg-8">
				<!-- 최근 구매 -->
				<div class="trending__product section-box">
					<div class="section-title">
						<h4>최근 구매 내역</h4>
						<a href="library.do" class="view-all">전체보기 &gt;</a>
					</div>
					<div class="row">
						<c:choose>
							<c:when test="${not empty recentPurchases}">
								<c:forEach var="purchase" items="${recentPurchases}">
									<div class="col-lg-4 col-md-6 col-sm-6">
										<div class="product__item">
											<div class="product__item__pic set-bg"
												data-setbg="${purchase.thumbnailImage}">
												<div class="ep">${fn:substring(purchase.purchaseDate, 0, 10)}</div>
											</div>
											<div class="product__item__text">
												<h5>
													<a href="gameDetails.do?gameCode=${purchase.gameCode}">${purchase.gameTitle}</a>
												</h5>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div class="col-lg-12">
									<p class="empty-message">아직 구매한 게임이 없습니다.</p>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

				<!-- 최근 게시글 -->
				<div class="trending__product section-box" style="margin-top: 40px;">
					<div class="section-title">
						<h4>최근 등록한 게시글</h4>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<c:choose>
								<c:when test="${not empty recentTopics}">
									<c:forEach var="topic" items="${recentTopics}">
										<div class="product__item__text">
											<h5>
												<a href="topicDetail.do?topicCode=${topic.topicCode}">${topic.topicTitle}</a>
											</h5>
											<p>${topic.writeDate} 작성 | 게임: ${topic.gameTitle}</p>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="product__item__text">
										<p style="color: #bbb;">아직 작성한 게시글이 없습니다. 게임 커뮤니티에서 다른 유저들과 소통해보세요!</p>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>

				<!-- 최근 리뷰 -->
				<div class="trending__product section-box" style="margin-top: 40px;">
					<div class="section-title">
						<h4>최근 작성한 리뷰</h4>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<c:choose>
								<c:when test="${not empty recentReviews}">
									<c:forEach var="review" items="${recentReviews}">
										<div class="product__item__text">
											<h5>
												${review.gameTitle} <small style="color: #aaa;"></small>
											</h5>
											<p>"${review.reviewContents}"</p>
											<small> ${review.writeDate} 작성 | <span class="stars">
													<c:set var="rating" value="${review.rating}" /> <c:forEach
														var="i" begin="1" end="5">
														<c:choose>
															<c:when test="${rating >= i}">
												              ★
												            </c:when>
															<c:when test="${rating >= i - 0.5}">
												              ☆
												            </c:when>
															<c:otherwise>
																☆
															</c:otherwise>
														</c:choose>
													</c:forEach>
													(${review.rating}/5)
												</span>
											</small>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="product__item__text">
										<p style="color: #bbb;">아직 작성한 리뷰가 없습니다. 마음에 드는 게임을 플레이하고
											첫 리뷰를 작성해보세요!</p>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
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
</script>
<link rel="stylesheet" href="css/gemdori/myPage.css" type="text/css">