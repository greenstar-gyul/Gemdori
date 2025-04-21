<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

<!-- Gemdori Section Begin -->
<section class="gemdori-details spad">
    <div class="container">
        <div class="gemdori__details__content">
            <div class="gemdori__details__title">
                <h3>${game.gameTitle}</h3>
            </div>
            <div class="row">
                <div class="col-lg-8">
                	<div class="hero__slider owl-carousel">
					<c:forEach var="gameImage" items="${game.imageList}">
						<div class="hero__items set-bg" data-setbg="${gameImage}" style="height: 524.5px;">
						</div>
					</c:forEach>
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
		                          <a href="#" id="addToCartBtn" class="follow-btn"><i class="fa fa-heart-o"></i>장바구니 추가</a>
		                          <a href="#" id="buyNowBtn" class="watch-btn"><span>바로 구매</span> <i class="fa fa-angle-right"></i></a>
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
                    <div class="system-req">
                        <h4 class="title">시스템 요구사항</h4>
                        <div class="row">
                            <c:choose>
                                <c:when test="${game.gameSysReqR == ''}">
                                    <div class="col-md-12 req-column">
                                        <h5>최소 사양</h5>
                                        ${game.gameSysReq}
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="col-md-6 req-column">
                                        <h5>최소 사양</h5>
                                        ${game.gameSysReq}
                                    </div>
                                    <div class="col-md-6 req-column">
                                        <h5>권장 사양</h5>
                                        ${game.gameSysReqR}
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
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
                                    <li><span>기본 게임</span><br>
                                        <c:choose>
                                            <c:when test="${empty game.parentGame}">
                                                원본 게임
                                            </c:when>
                                            <c:otherwise>
                                                DLC <a href="gameDetails.do?gameCode=${game.parentGame}">원본 게임</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
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
                        <div id="reviewListContainer">
                            
                            <p>리뷰를 불러오는 중입니다...</p>
                        </div>
                    </div>
                    <div class="gemdori__details__form">
                        <div class="section-title">
                            <h5>Your Comment</h5>
                        </div>
                        <%-- ▼▼▼ 리뷰 등록 폼 수정 시작 ▼▼▼ --%>
                        <c:choose>
                            <c:when test="${empty sessionScope.loginUser}">
                                <%-- 1. 로그인 안했을 때: 로그인 안내 메시지 표시 --%>
                                <p><a href="${pageContext.request.contextPath}/loginForm.do">로그인</a> 후 리뷰를 작성할 수 있습니다.</p>
                            </c:when>
                            <c:otherwise>
                                <%-- 2. 로그인 했을 때: 폼 표시 --%>

                                <%-- 2-1. 서버(Controller)에서 전달된 오류 메시지 표시 영역 --%>
                                <div id="reviewErrorMsg" style="color: red; margin-bottom: 10px;">
                                    <%-- requestScope에 errorMsg 속성이 있으면 그 값을 출력 --%>
                                    <c:if test="${not empty errorMsg}">
                                        ${errorMsg}
                                    </c:if>
                                </div>

                                <%-- 2-2. 기존 폼 구조 유지 --%>
                                <form id="reviewForm" action="reviewAdd.do" method="post">
                                    <input type="hidden" name="gameCode" value="${game.gameCode}"/>
                                    <textarea name="reviewContents" placeholder="Your Comment" required></textarea>

                                    <%-- 2-3. 별점 select 수정 (0.5 단위 추가, 기본 옵션 추가) --%>
                                    <label>Rating: </label>
                                    <div class="star-rating" style="display: inline-block; font-size: 1.5em; cursor: pointer; color: #ffca08;">
                                        <%--
                                            별 아이콘 5개를 0.5점 단위로 표시하기 위해 총 10개의 반쪽 별 영역(span)을 만듭니다.
                                            각 span은 data-value 속성에 해당 위치까지의 누적 점수를 가집니다.
                                            초기에는 모두 빈 별(fa-star-o) 아이콘으로 표시됩니다.
                                            (Font Awesome 라이브러리가 필요합니다.)
                                        --%>
                                        <span class="star" data-value="1.0"><i class="fa fa-star-o"></i></span>
                                        <span class="star" data-value="2.0"><i class="fa fa-star-o"></i></span>
                                        <span class="star" data-value="3.0"><i class="fa fa-star-o"></i></span>
                                        <span class="star" data-value="4.0"><i class="fa fa-star-o"></i></span>
                                        <span class="star" data-value="5.0"><i class="fa fa-star-o"></i></span>
                                        <span class="current-rating" style="margin-left: 10px; font-size: 0.8em; color: #555;">(0.0 점)</span> <%-- 선택된 점수를 텍스트로 보여줄 영역 --%>
                                    </div>
                                    <%--
                                        사용자가 클릭한 최종 별점 값을 서버로 전송하기 위한 hidden input 필드입니다.
                                        name="rating"은 Controller에서 req.getParameter("rating")으로 받을 이름과 동일해야 합니다.
                                        id="ratingValue"는 JavaScript에서 이 필드의 값을 업데이트하기 위해 사용됩니다.
                                    --%>
                                    <input type="hidden" name="rating" id="ratingValue" value="">

                                    <button type="submit"><i class="fa fa-location-arrow"></i> Review</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Js Plugins -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/player.js"></script>
<script src="js/jquery.nice-select.min.js"></script>
<script src="js/mixitup.min.js"></script>
<script src="js/jquery.slicknav.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/main.js"></script>
<script>
const currentGameCode = "${game.gameCode}";
const loggedInUserCode = "${sessionScope.loginUser != null ? sessionScope.loginUser.userCode : ''}";
const contextPath = "${pageContext.request.contextPath}";

<!-- 장바구니 관련 JavaScript 로직 추가 -->
$(document).ready(function() {
    // 장바구니 추가 버튼 클릭 이벤트
    $('#addToCartBtn').click(function(e) {
        e.preventDefault(); // 기본 링크 동작 방지
        
        // 현재 URL에서 gameCode 파라미터 값 가져오기
        var gameCode = getParameterByName('gameCode');
        
        // 로그인 상태 확인 (세션에 loginUser가 있는지)
        var isLoggedIn = <%= session.getAttribute("loginUser") != null %>;
        
        if (!isLoggedIn) {
            alert('로그인이 필요한 서비스입니다.');
            window.location.href = 'login.do?redirect=gameDetails.do?gameCode=' + gameCode;
            return;
        }
        
        // 버튼 상태 변경 (클릭 비활성화)
        var $btn = $(this);
        $btn.addClass('disabled').css('pointer-events', 'none');
        
        // 디버깅 로그 추가
        console.log("장바구니 추가 요청: " + gameCode);
        
        $.ajax({
            url: 'addToCart.do', // 컨트롤러를 통해 처리하는 URL
            type: 'POST',
            data: { gameCode: gameCode },
            success: function(response) {
                // 디버깅 로그 추가
                console.log("서버 응답: " + response);
                
                // 버튼 상태 복원
                $btn.removeClass('disabled').css('pointer-events', 'auto');
                
                if (response === 'success') {
                    // 아이콘 변경 (빈 하트 → 채워진 하트)
                    $btn.find('i').removeClass('fa-heart-o').addClass('fa-heart');
                    
                    // 성공 메시지와 함께 장바구니로 이동할지 묻는 확인 창
                    if(confirm('게임이 장바구니에 추가되었습니다! 장바구니로 이동할까요?')) {
                        window.location.href = 'cartPage.do';
                    }
                } else if (response === 'already_exists') {
                    alert('이미 장바구니에 추가된 상품입니다.');
                    $btn.find('i').removeClass('fa-heart-o').addClass('fa-heart');
                } else if (response === 'login_required') {
                    alert('로그인이 필요한 서비스입니다.');
                    window.location.href = 'login.do?redirect=gameDetails.do?gameCode=' + gameCode;
                } else {
                    alert('장바구니 추가에 실패했습니다. 다시 시도해주세요.');
                }
            },
            error: function(xhr, status, error) {
                // 버튼 상태 복원
                $btn.removeClass('disabled').css('pointer-events', 'auto');
                
                alert('장바구니 추가 중 오류가 발생했습니다. 다시 시도해주세요.');
                console.error('Error:', error);
            }
        });
    });
    
    // Buy Now 버튼 클릭 이벤트
    $('#buyNowBtn').click(function(e) {
        e.preventDefault(); // 기본 링크 동작 방지
        
        // 현재 URL에서 gameCode 파라미터 값 가져오기
        var gameCode = getParameterByName('gameCode');
        
        // 로그인 상태 확인
        var isLoggedIn = <%= session.getAttribute("loginUser") != null %>;
        
        if (!isLoggedIn) {
            alert('로그인이 필요한 서비스입니다.');
            window.location.href = 'login.do?redirect=gameDetails.do?gameCode=' + gameCode;
            return;
        }
        
        // 버튼 상태 변경 (클릭 비활성화)
        var $btn = $(this);
        $btn.addClass('disabled').css('pointer-events', 'none');
        
        // 게임을 장바구니에 추가하고 바로 결제 페이지로 이동
        $.ajax({
            url: 'addToCart.do',
            type: 'POST',
            data: { gameCode: gameCode, buyNow: true },
            success: function(response) {
                if (response === 'success' || response === 'already_exists') {
                    window.location.href = 'checkout.do';
                } else if (response === 'login_required') {
                    // 버튼 상태 복원
                    $btn.removeClass('disabled').css('pointer-events', 'auto');
                    alert('로그인이 필요한 서비스입니다.');
                    window.location.href = 'login.do?redirect=gameDetails.do?gameCode=' + gameCode;
                } else {
                    // 버튼 상태 복원
                    $btn.removeClass('disabled').css('pointer-events', 'auto');
                    alert('구매 처리 중 오류가 발생했습니다. 다시 시도해주세요.');
                }
            },
            error: function(xhr, status, error) {
                // 버튼 상태 복원
                $btn.removeClass('disabled').css('pointer-events', 'auto');
                alert('구매 처리 중 오류가 발생했습니다. 다시 시도해주세요.');
                console.error('Error:', error);
            }
        });
    });
    
    // URL 파라미터 값 가져오는 함수
    function getParameterByName(name) {
        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
        return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    }
    
    // 페이지 로드 시 이 게임이 이미 장바구니에 있는지 확인
    function checkCartStatus() {
        var gameCode = getParameterByName('gameCode');
        var isLoggedIn = <%= session.getAttribute("loginUser") != null %>;
        
        if (isLoggedIn && gameCode) {
            $.ajax({
                url: 'checkCart.do',
                type: 'GET',
                data: { gameCode: gameCode },
                success: function(inCart) {
                    if (inCart === 'true') {
                        // 이미 장바구니에 있으면 아이콘 변경
                        $('#addToCartBtn').find('i').removeClass('fa-heart-o').addClass('fa-heart');
                    }
                }
            });
        }
    }
    
    // 페이지 로드 시 장바구니 상태 확인
    checkCartStatus();
});
</script>
<script src="js/main/review.js"></script>
