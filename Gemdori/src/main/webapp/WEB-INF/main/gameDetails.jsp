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
                                            <span class="star" data-value="0.5"><i class="fa fa-star-o"></i></span><span class="star" data-value="1.0"><i class="fa fa-star-o"></i></span>
                                            <span class="star" data-value="1.5"><i class="fa fa-star-o"></i></span><span class="star" data-value="2.0"><i class="fa fa-star-o"></i></span>
                                            <span class="star" data-value="2.5"><i class="fa fa-star-o"></i></span><span class="star" data-value="3.0"><i class="fa fa-star-o"></i></span>
                                            <span class="star" data-value="3.5"><i class="fa fa-star-o"></i></span><span class="star" data-value="4.0"><i class="fa fa-star-o"></i></span>
                                            <span class="star" data-value="4.5"><i class="fa fa-star-o"></i></span><span class="star" data-value="5.0"><i class="fa fa-star-o"></i></span>
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
            </div>
        </section>
        
        <script>
    // ============================================
    // ▼▼▼ 전역 변수 선언 ▼▼▼
    // ============================================
    // 현재 로그인한 사용자의 userCode (없으면 빈 문자열)
    // (주의!) EL 3.0 이상에서만 ?. 연산자 사용 가능. 하위 버전이면 c:choose 또는 스크립틀릿 사용 필요.
    const loggedInUserCode = "${sessionScope.loginUser != null ? sessionScope.loginUser.userCode : ''}";
    // 현재 게임 코드
    const currentGameCode = "${game.gameCode}";
    // 리뷰 목록 컨테이너 (DOM 로드 후 실제 할당)
    let reviewListContainer = null;


    // ============================================
    // ▼▼▼ DOMContentLoaded 이벤트 리스너 ▼▼▼
    // ============================================
    document.addEventListener('DOMContentLoaded', function() {

        // 리뷰 목록 컨테이너 요소 찾기
        reviewListContainer = document.getElementById('reviewListContainer');

        // --- 별점 기능 초기화 ---
        const starRatingContainer = document.querySelector('.star-rating');
        if (starRatingContainer) { // 로그인 했을 때만 별점 코드 실행
            const stars = starRatingContainer.querySelectorAll('.star');
            const currentRatingSpan = starRatingContainer.querySelector('.current-rating');
            const ratingValueInput = document.getElementById('ratingValue');
            let currentRating = 0.0;

            function updateStars(rating) {
                stars.forEach(star => {
                    const starValue = parseFloat(star.dataset.value);
                    const starIcon = star.querySelector('i');
                    const faEmpty = 'fa-star-o', faHalf = 'fa-star-half-o', faFull = 'fa-star';

                    starIcon.classList.remove(faFull, faHalf);
                    starIcon.classList.add(faEmpty);

                    if (rating >= starValue) {
                        starIcon.classList.remove(faEmpty);
                        starIcon.classList.add(faFull);
                    } else if (rating >= starValue - 0.5) {
                        starIcon.classList.remove(faEmpty);
                        starIcon.classList.add(faHalf);
                    }
                });
            }

            stars.forEach(star => {
                star.addEventListener('click', function() {
                    const clickedValue = parseFloat(this.dataset.value);
                    currentRating = clickedValue;
                    updateStars(currentRating);
                    currentRatingSpan.textContent = `(${currentRating.toFixed(1)} 점)`;
                    ratingValueInput.value = currentRating;
                    console.log('별점 선택됨:', ratingValueInput.value);
                });
                star.addEventListener('mouseover', function() {
                    const hoverValue = parseFloat(this.dataset.value);
                    updateStars(hoverValue);
                });
                star.addEventListener('mouseout', function() {
                    updateStars(currentRating);
                });
            });
        } // --- 별점 기능 초기화 끝 ---


        // --- 페이지 로드 시 리뷰 목록 최초 로딩 ---
        if (currentGameCode && reviewListContainer) {
            loadReviews(currentGameCode);
        } // --- 최초 로딩 끝 ---

    }); // <-- DOMContentLoaded 끝


    // ============================================
    // ▼▼▼ 함수 정의 (전역 스코프) ▼▼▼
    // ============================================

    // --- 리뷰 목록 로딩 함수 ---
    function loadReviews(gameCode) {
        // reviewListContainer가 아직 준비되지 않았으면 중단
        if (!reviewListContainer) {
            console.warn("리뷰 목록 컨테이너를 찾을 수 없습니다.");
            return;
        }
        reviewListContainer.innerHTML = '<p>리뷰를 불러오는 중입니다...</p>';

        fetch(`${pageContext.request.contextPath}/reviewList.do?gameCode=${gameCode}`)
            .then(response => {
                if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
                return response.json();
            })
            .then(reviews => {
                reviewListContainer.innerHTML = ''; // 컨테이너 비우기

                if (!reviews || reviews.length === 0) {
                    reviewListContainer.innerHTML = '<p>아직 등록된 리뷰가 없습니다.</p>';
                    return;
                }

                reviews.forEach(review => {
                    const reviewElement = document.createElement('div');
                    reviewElement.classList.add('gemdori__review__item'); // CSS 클래스
                    reviewElement.id = `review-${review.reviewCode}`; // 고유 ID

                    // 삭제 버튼 생성 (로그인 && 본인 글 확인)
                    let deleteButtonHtml = '';
                    if (loggedInUserCode && loggedInUserCode === review.userCode) {
                        deleteButtonHtml = `
                            <button class="review-delete-btn" onclick="deleteReview('${review.reviewCode}')">
                                <i class="fa fa-trash"></i> 삭제
                            </button>
                        `;
                    }

                    // 리뷰 HTML 구조 생성
                    reviewElement.innerHTML = `
                        <div class="gemdori__review__item__pic">
                            <img src="${review.userImage ? review.userImage : '${pageContext.request.contextPath}/img/default-profile.png'}" alt="${review.userName}">
                        </div>
                        <div class="gemdori__review__item__text">
                            <h6>
                                ${review.userName} - <span>${formatDate(review.writeDate)}</span>
                                ${deleteButtonHtml} <%-- 삭제 버튼 삽입 --%>
                            </h6>
                            <div class="rating">
                                ${renderStarsForDisplay(review.rating)}
                                <span>(${review.rating.toFixed(1)})</span>
                            </div>
                            <p>${escapeHtml(review.reviewContents)}</p>
                        </div>
                    `;
                    reviewListContainer.appendChild(reviewElement);
                });
            })
            .catch(error => {
                console.error('리뷰 목록 로딩 오류:', error);
                reviewListContainer.innerHTML = '<p>리뷰를 불러오는 중 오류가 발생했습니다.</p>';
            });
    } // --- 리뷰 목록 로딩 함수 끝 ---


    // --- 별점 표시용 아이콘 생성 함수 ---
    function renderStarsForDisplay(rating) {
        let starsHtml = '';
        const fullStars = Math.floor(rating);
        const halfStar = (rating % 1 >= 0.5) ? 1 : 0;
        const emptyStars = 5 - fullStars - halfStar;
        for (let i = 0; i < fullStars; i++) starsHtml += '<i class="fa fa-star"></i> ';
        if (halfStar) starsHtml += '<i class="fa fa-star-half-o"></i> ';
        for (let i = 0; i < emptyStars; i++) starsHtml += '<i class="fa fa-star-o"></i> ';
        return starsHtml.trim();
    } // --- 별점 표시 함수 끝 ---


    // --- 날짜 포맷팅 함수 ---
    function formatDate(dateString) {
        if (!dateString) return '';
        return dateString.substring(0, 16); // YYYY-MM-DD HH:MM
    } // --- 날짜 포맷팅 함수 끝 ---


	 // --- HTML 이스케이프 함수 (XSS 방지) ---
//     function escapeHtml(unsafe) {
        if (unsafe === null || unsafe === undefined) return '';
        // ▼▼▼ 이렇게 수정해야 합니다! ▼▼▼
        return unsafe
             .replace(/&/g, "&amp;")
             .replace(/</g, "&lt;")
             .replace(/>/g, "&gt;")
             .replace(/"/g, "&quot;")
             .replace(/'/g, "&apos;");
    } // --- HTML 이스케이프 함수 끝 ---


    // --- 리뷰 삭제 함수 ---
    function deleteReview(reviewCode) {
        if (!reviewCode) {
            console.error('삭제할 리뷰 코드가 없습니다.');
            return;
        }
        if (!confirm('정말 이 리뷰를 삭제하시겠습니까?')) {
            return;
        }

        const formData = new FormData();
        formData.append('reviewCode', reviewCode);

        fetch(`${pageContext.request.contextPath}/removeReview.do`, {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(result => {
            alert(result.message); // 결과 메시지 알림
            if (result.success) {
                loadReviews(currentGameCode); // 성공 시 목록 새로고침
            }
        })
        .catch(error => {
            console.error('리뷰 삭제 요청 오류:', error);
            alert('리뷰 삭제 중 오류가 발생했습니다.');
        });
    } // --- 리뷰 삭제 함수 끝 ---

</script>