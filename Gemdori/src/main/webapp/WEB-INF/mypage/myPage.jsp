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
							<li><a href="#">📦 구매 내역</a></li>
							<li><a href="#">📝 나의 리뷰</a></li>
							<li><a href="#">📋 게시글 관리</a></li>
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
					</div>
					<div class="row">
						<div class="col-lg-4 col-md-6 col-sm-6">
							<div class="product__item">
								<div class="product__item__pic set-bg"
									data-setbg="img/trending/trend-1.jpg">
									<div class="ep">2025-04-01</div>
								</div>
								<div class="product__item__text">
									<ul>
										<li>RPG</li>
										<li>Adventure</li>
									</ul>
									<h5>Elden Ring</h5>
								</div>
							</div>
						</div>
						<div class="col-lg-4 col-md-6 col-sm-6">
							<div class="product__item">
								<div class="product__item__pic set-bg"
									data-setbg="img/trending/trend-2.jpg">
									<div class="ep">2025-03-21</div>
								</div>
								<div class="product__item__text">
									<ul>
										<li>Shooter</li>
										<li>Co-op</li>
									</ul>
									<h5>Helldivers 2</h5>
								</div>
							</div>
						</div>
						<div class="col-lg-4 col-md-6 col-sm-6">
							<div class="product__item">
								<div class="product__item__pic set-bg"
									data-setbg="img/trending/trend-4.jpg">
									<div class="ep">2025-03-21</div>
								</div>
								<div class="product__item__text">
									<ul>
										<li>Shooter</li>
										<li>Co-op</li>
									</ul>
									<h5>Helldivers 2</h5>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- 최근 게시글 -->
				<div class="trending__product section-box" style="margin-top: 40px;">
					<div class="section-title">
						<h4>최근 등록한 게시글</h4>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<div class="product__item__text">
								<h5>
									<a href="#">[자유] 엘든링 DLC 언제 나올까요?</a>
								</h5>
								<p>2025-04-20 작성 | 댓글 4</p>
							</div>
							<div class="product__item__text">
								<h5>
									<a href="#">[리뷰] 헬다이버2 진짜 갓겜입니다</a>
								</h5>
								<p>2025-04-18 작성 | 댓글 2</p>
							</div>
							<div class="product__item__text">
								<h5>
									<a href="#">[리뷰] 레포데는 진짜 똥겜입니다</a>
								</h5>
								<p>2025-04-15 작성 | 댓글 5</p>
							</div>
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
	// 자바스크립트에서 JSTL 데이터를 직접 객체로 출력
	console.log("최근 리뷰 데이터:");
	<c:forEach var="review" items="${recentReviews}">
	console.log({
		gameTitle : "${review.gameTitle}",
		reviewContents : "${review.reviewContents}",
		writeDate : "${review.writeDate}",
		rating : "${review.rating}"
	});
	</c:forEach>
</script>
<link rel="stylesheet" href="css/gemdori/myPage.css" type="text/css">