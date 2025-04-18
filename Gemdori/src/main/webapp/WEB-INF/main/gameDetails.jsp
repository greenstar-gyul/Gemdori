<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="css/gemdori/gameDetails.css" type="text/css">

<!-- Breadcrumb Begin -->
<div class="breadcrumb-option">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="breadcrumb__links">
                    <a href="main.do"><i class="fa fa-home"></i> Home</a>
                    <a href="main.do">Categories</a>
                    <span>${game.gameTitle}</span>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Breadcrumb End -->

<!-- Anime Section Begin -->
<section class="gemdori-details spad">
    <div class="container">
        <div class="gemdori__details__content">
            <div class="gemdori__details__title">
                <h3>${game.gameTitle}</h3>
            </div>
            <div class="row">
                <div class="col-lg-8">
                    <div class="gemdori__details__pic set-bg" data-setbg="${game.gameMainImage}">
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="gemdori__details__text">
                        <div class="gemdori__details__rating">
                            <div class="game-desc-contents">
                                <h5>${game.gameTitle}</h5>
                                <br>
	                            <p>${game.gameDesc}</p>
                            </div>
                            <div class="rating">
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star-half-o"></i></a>
                                <span>${game.gameRating} Votes</span>
                            </div>
		                      <div class="gemdori__details__btn">
		                          <a href="#" class="follow-btn"><i class="fa fa-heart-o"></i>add to cart</a>
		                          <a href="#" class="watch-btn"><span>Buy Now</span> <i class="fa fa-angle-right"></i></a>
		                      </div>
                        </div>
                    </div>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-lg-8 col-md-8 main-contents-bg">
                    <div class="gemdori__details__main">
                        <div class="contents-title">
                            <h4>ABOUT THIS GAME</h4>
                        </div>
                        <div class="about contents-box">
                            <p>${game.gameContents}</p>
                        </div>
                    </div>
                    <br>
                    <!-- 나머지 영역은 원래 코드에서 필요한 만큼 계속 채워가면 됨 -->
                </div>
                <div class="col-lg-4 col-md-4">
                    <div class="gemdori__details__widget">
                        <div class="row">
                            <div class="info-contents-bg">
                                <ul>
                                    <li><span>개발사</span><br> ${game.gameDeveloper}</li>
                                    <li><span>퍼블리셔</span><br> ${game.gamePublisher}</li>
                                    <li><span>출시일</span><br> ${game.publishingDate}</li>
                                    <li><span>플랫폼</span><br> ${game.gameCategory}</li>
                                    <li><span>장르</span><br> ${game.gameGenre}</li>
                                    <li><span>언어</span><br> ${game.languageSup}</li>
                                    <li><span>연령 제한</span><br>${game.requiredAge == 0 ? '전체 이용가' : game.requiredAge}</li>
                                    <li><span>기본 게임</span><br> ${game.parentGame == null ? '원본 게임' : 'DLC (기반: ' + game.parentGame + ')'}</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="gemdori__details__sidebar">
                        <div class="section-title">
                            <h5>you might like...</h5>
                        </div>
                        <div class="product__sidebar__view__item set-bg" data-setbg="img/sidebar/tv-1.jpg">
                            <div class="ep">18 / ?</div>
                            <div class="view"><i class="fa fa-eye"></i> 9141</div>
                            <h5><a href="#">Boruto: Naruto next generations</a></h5>
                        </div>
                        <div class="product__sidebar__view__item set-bg" data-setbg="img/sidebar/tv-2.jpg">
                            <div class="ep">18 / ?</div>
                            <div class="view"><i class="fa fa-eye"></i> 9141</div>
                            <h5><a href="#">The Seven Deadly Sins: Wrath of the Gods</a></h5>
                        </div>
                        <div class="product__sidebar__view__item set-bg" data-setbg="img/sidebar/tv-3.jpg">
                            <div class="ep">18 / ?</div>
                            <div class="view"><i class="fa fa-eye"></i> 9141</div>
                            <h5><a href="#">Sword art online alicization war of underworld</a></h5>
                        </div>
                        <div class="product__sidebar__view__item set-bg" data-setbg="img/sidebar/tv-4.jpg">
                            <div class="ep">18 / ?</div>
                            <div class="view"><i class="fa fa-eye"></i> 9141</div>
                            <h5><a href="#">Fate/stay night: Heaven's Feel I. presage flower</a></h5>
                        </div>
                    </div>
                </div>
            </div>
                <br>
                <div class="row">
                    <div class="col-lg-8 col-md-8 main-contents-bg">
                        <div class="gemdori__details__review">
                            <div class="contents-title">
                                <h5>Reviews</h5>
                            </div>
                            <div class="gemdori__review__item">
                                <div class="gemdori__review__item__pic">
                                    <img src="img/gemdori/review-1.jpg" alt="">
                                </div>
                                <div class="gemdori__review__item__text">
                                    <h6>Chris Curry - <span>1 Hour ago</span></h6>
                                    <p>whachikan Just noticed that someone categorized this as belonging to the genre
                                    "demons" LOL</p>
                                </div>
                            </div>
                            <div class="gemdori__review__item">
                                <div class="gemdori__review__item__pic">
                                    <img src="img/gemdori/review-2.jpg" alt="">
                                </div>
                                <div class="gemdori__review__item__text">
                                    <h6>Lewis Mann - <span>5 Hour ago</span></h6>
                                    <p>Finally it came out ages ago</p>
                                </div>
                            </div>
                            <div class="gemdori__review__item">
                                <div class="gemdori__review__item__pic">
                                    <img src="img/gemdori/review-3.jpg" alt="">
                                </div>
                                <div class="gemdori__review__item__text">
                                    <h6>Louis Tyler - <span>20 Hour ago</span></h6>
                                    <p>Where is the episode 15 ? Slow update! Tch</p>
                                </div>
                            </div>
                            <div class="gemdori__review__item">
                                <div class="gemdori__review__item__pic">
                                    <img src="img/gemdori/review-4.jpg" alt="">
                                </div>
                                <div class="gemdori__review__item__text">
                                    <h6>Chris Curry - <span>1 Hour ago</span></h6>
                                    <p>whachikan Just noticed that someone categorized this as belonging to the genre
                                    "demons" LOL</p>
                                </div>
                            </div>
                            <div class="gemdori__review__item">
                                <div class="gemdori__review__item__pic">
                                    <img src="img/gemdori/review-5.jpg" alt="">
                                </div>
                                <div class="gemdori__review__item__text">
                                    <h6>Lewis Mann - <span>5 Hour ago</span></h6>
                                    <p>Finally it came out ages ago</p>
                                </div>
                            </div>
                            <div class="gemdori__review__item">
                                <div class="gemdori__review__item__pic">
                                    <img src="img/gemdori/review-6.jpg" alt="">
                                </div>
                                <div class="gemdori__review__item__text">
                                    <h6>Louis Tyler - <span>20 Hour ago</span></h6>
                                    <p>Where is the episode 15 ? Slow update! Tch</p>
                                </div>
                            </div>
                        </div>
                        <div class="gemdori__details__form">
                            <div class="section-title">
                                <h5>Your Comment</h5>
                            </div>
                            <form id="reviewForm" action="#">
                                <textarea name="reviewContent" placeholder="Your Comment" required></textarea>
                                <button type="submit"><i class="fa fa-location-arrow"></i> Review</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>