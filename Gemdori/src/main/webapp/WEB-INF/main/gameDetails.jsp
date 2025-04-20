<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="css/gemdori/gameDetails.css" type="text/css">
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
		    document.addEventListener('DOMContentLoaded', function() {

		    	// 1. 필요한 HTML 요소들을 찾아서 변수에 저장
	            const starRatingContainer = document.querySelector('.star-rating'); // 별점 전체 영역
	            // starRatingContainer가 없을 경우(예: 로그인 안 함) 오류 방지
	            if (!starRatingContainer) return;

	            const stars = starRatingContainer.querySelectorAll('.star'); // 별 아이콘들을 감싸는 span 요소들 (NodeList)
	            const currentRatingSpan = starRatingContainer.querySelector('.current-rating'); // 점수 텍스트 표시 영역
	            const ratingValueInput = document.getElementById('ratingValue'); // 서버로 전송될 점수 값을 담는 hidden input

	            let currentRating = 0.0; // 현재 사용자가 최종 선택한 별점 값을 저장할 변수 (초기값 0)

	            // 2. 별 모양을 업데이트하는 함수 정의
	            //    - 파라미터(rating): 표시할 별점 (예: 3.5)
	            function updateStars(rating) {
	                stars.forEach(star => {
	                    // 각 별 span 요소가 가지고 있는 data-value 속성 값을 숫자로 변환 (예: "3.5" -> 3.5)
	                    const starValue = parseFloat(star.dataset.value);
	                    // 각 별 span 안에 있는 아이콘(<i>) 태그 찾기
	                    const starIcon = star.querySelector('i');

	                    // Font Awesome 아이콘 클래스 이름 정의
	                    const faEmpty = 'fa-star-o'; // 빈 별
	                    const faHalf = 'fa-star-half-o'; // 반쪽 별
	                    const faFull = 'fa-star'; // 꽉 찬 별

	                    // 일단 모든 아이콘에서 꽉찬별/반쪽별 클래스를 제거하고 빈 별 클래스를 추가 (초기화)
	                    starIcon.classList.remove(faFull, faHalf);
	                    starIcon.classList.add(faEmpty);

	                    // 입력된 점수(rating)와 현재 별의 값(starValue)을 비교하여 아이콘 클래스 변경
	                    if (rating >= starValue) {
	                        // 예: rating=3.5, starValue=3.5 -> 꽉 찬 별
	                        // 예: rating=3.5, starValue=3.0 -> 꽉 찬 별
	                        starIcon.classList.remove(faEmpty);
	                        starIcon.classList.add(faFull);
	                    } else if (rating >= starValue - 0.5) {
	                        // 예: rating=3.5, starValue=4.0 -> 반쪽 별 (3.5 >= 4.0 - 0.5)
	                        starIcon.classList.remove(faEmpty);
	                        starIcon.classList.add(faHalf);
	                    }
	                    // 그 외의 경우 (rating < starValue - 0.5)는 이미 위에서 초기화된 빈 별 상태 유지
	                    // 예: rating=3.5, starValue=4.5 -> 빈 별 (3.5 < 4.5 - 0.5)
	                });
	            }
	            
	         // ============================================
                // ▼▼▼ 리뷰 목록 로딩 AJAX 코드 추가 ▼▼▼
                // ============================================

                // 1. 리뷰 목록을 표시할 컨테이너 요소 찾기
                const reviewListContainer = document.getElementById('reviewListContainer');
                // 2. 현재 페이지의 gameCode 가져오기 (JSP의 EL 표현식 사용)
                //    (주의!) JSP EL 표현식을 JavaScript 문자열 안에 직접 사용할 때는 따옴표 처리에 유의해야 합니다.
                const currentGameCode = "${game.gameCode}"; // EL 값을 JS 변수에 할당

                // 3. 리뷰 목록을 가져오는 함수 정의
                function loadReviews(gameCode) {
                    // 로딩 메시지 표시 (기존 컨테이너 내용 비우고 시작)
                    reviewListContainer.innerHTML = '<p>리뷰를 불러오는 중입니다...</p>';

                    // fetch API를 사용하여 서버에 리뷰 목록 요청
                    // (FrontController에 매핑된 /reviewList.do 경로 사용)
                    fetch(`${pageContext.request.contextPath}/reviewList.do?gameCode=${gameCode}`) // ContextPath 포함
                        .then(response => {
                            // 응답 상태 확인 (200 OK 아니면 오류 처리)
                            if (!response.ok) {
                                throw new Error(`HTTP error! status: ${response.status}`);
                            }
                            // 응답 본문을 JSON으로 파싱
                            return response.json();
                        })
                        .then(reviews => { // JSON 데이터 (리뷰 배열) 수신 성공
                            // 컨테이너 내용 비우기
                            reviewListContainer.innerHTML = '';

                            // 리뷰 데이터가 없거나 배열이 비어있는 경우
                            if (!reviews || reviews.length === 0) {
                                reviewListContainer.innerHTML = '<p>아직 등록된 리뷰가 없습니다.</p>';
                                return; // 함수 종료
                            }

                            // 리뷰 목록을 순회하며 HTML 생성
                            reviews.forEach(review => {
                                // 각 리뷰를 표시할 HTML 구조 생성 (div 요소 사용 예시)
                                const reviewElement = document.createElement('div');
                                reviewElement.classList.add('gemdori__review__item'); // CSS 스타일링을 위한 클래스 추가 (선택사항)

                                // 리뷰 내용, 별점, 작성자 정보 등을 포함하는 HTML 구성
                                reviewElement.innerHTML = `
                                    <div class="gemdori__review__item__pic">
                                        <%-- 사용자 프로필 이미지 (없으면 기본 이미지 표시) --%>
                                        <img src="${review.userImage ? review.userImage : '${pageContext.request.contextPath}/img/default-profile.png'}" alt="${review.userName}">
                                    </div>
                                    <div class="gemdori__review__item__text">
                                        <h6>${review.userName} - <span>${formatDate(review.writeDate)}</span></h6>
                                        <div class="rating">
                                            ${renderStarsForDisplay(review.rating)} <%-- 별점 표시 함수 호출 --%>
                                            <span>(${review.rating.toFixed(1)})</span> <%-- 숫자 점수 표시 --%>
                                        </div>
                                        <p>${escapeHtml(review.reviewContents)}</p> <%-- XSS 방지 처리 --%>
                                    </div>
                                `;
                                // (선택) 리뷰 삭제 버튼 추가 (로그인 사용자 == 리뷰 작성자 일 경우)
                                // if ('${sessionScope.loginUser?.userCode}' === review.userCode) { // EL과 JS 비교 주의
                                //     const deleteButton = document.createElement('button');
                                //     deleteButton.textContent = '삭제';
                                //     deleteButton.onclick = function() { deleteReview(review.reviewCode); };
                                //     reviewElement.querySelector('.gemdori__review__item__text').appendChild(deleteButton);
                                // }


                                // 생성된 리뷰 HTML 요소를 컨테이너에 추가
                                reviewListContainer.appendChild(reviewElement);
                            });

                        })
                        .catch(error => {
                            // fetch 요청 또는 처리 중 오류 발생 시
                            console.error('리뷰 목록 로딩 오류:', error);
                            reviewListContainer.innerHTML = '<p>리뷰를 불러오는 중 오류가 발생했습니다.</p>';
                        });
                }

                // 4. 별점 표시를 위한 HTML 생성 함수 (0.5 단위 반영)
                function renderStarsForDisplay(rating) {
                    let starsHtml = '';
                    const fullStars = Math.floor(rating); // 꽉 찬 별 개수
                    const halfStar = (rating % 1 >= 0.5) ? 1 : 0; // 반쪽 별 개수 (0 또는 1)
                    const emptyStars = 5 - fullStars - halfStar; // 빈 별 개수

                    for (let i = 0; i < fullStars; i++) {
                        starsHtml += '<i class="fa fa-star"></i> ';
                    }
                    if (halfStar) {
                        starsHtml += '<i class="fa fa-star-half-o"></i> ';
                    }
                    for (let i = 0; i < emptyStars; i++) {
                        starsHtml += '<i class="fa fa-star-o"></i> ';
                    }
                    return starsHtml.trim(); // 마지막 공백 제거
                }

                // 5. 날짜 포맷팅 함수 (간단 예시: YYYY-MM-DD HH:MM)
                // ReviewListControl에서 GsonBuilder().setDateFormat() 설정과 일치해야 함
                function formatDate(dateString) {
                    if (!dateString) return '';
                    // 서버에서 "yyyy-MM-dd HH:mm:ss" 형태로 문자열이 온다고 가정
                    // 초(ss) 부분은 제외하고 표시
                    return dateString.substring(0, 16); // "yyyy-MM-dd HH:mm"
                    // 필요시 더 복잡한 포맷팅 라이브러리 (예: moment.js, day.js) 사용 고려
                }

                // 6. HTML 내용에 포함될 사용자 입력값 이스케이프 처리 함수 (XSS 방지)
                function escapeHtml(unsafe) {
                    if (unsafe === null || unsafe === undefined) {
                        return '';
                    }
                    return unsafe
                         .replace(/&/g, "&")
                         .replace(/</g, "<")
                         .replace(/>/g, ">")
                         .replace(/"/g, """)
                         .replace(/'/g, "'");
                }

                // 7. 페이지 로드 시 리뷰 목록 로딩 함수 호출
                if (currentGameCode && reviewListContainer) { // gameCode와 컨테이너가 모두 있을 때만 실행
                    loadReviews(currentGameCode);
                }

                // (참고) 리뷰 삭제 함수 예시 (실제 구현 시 필요)
                
                function deleteReview(reviewCode) {
                    if (!confirm('정말 이 리뷰를 삭제하시겠습니까?')) {
                        return;
                    }
                    // fetch로 DELETE 요청 보내는 로직 구현 (별도 Control 필요)
                    console.log('삭제할 리뷰 코드:', reviewCode);
                    // 삭제 성공 후 loadReviews(currentGameCode); 다시 호출하여 목록 갱신
                }
                

                // ============================================
                // ▲▲▲ 리뷰 목록 로딩 AJAX 코드 끝 ▲▲▲
                // ============================================

	            // 3. 각 별(span.star) 요소에 이벤트 리스너 추가
	            stars.forEach(star => {
	                // --- 클릭 이벤트 처리 ---
	                star.addEventListener('click', function() {
	                    // 클릭된 별의 data-value 값을 숫자로 가져옴
	                    const clickedValue = parseFloat(this.dataset.value);
	                    // 현재 선택된 별점 값을 업데이트
	                    currentRating = clickedValue;

	                    // updateStars 함수를 호출하여 별 모양을 최종 선택된 상태로 업데이트
	                    updateStars(currentRating);

	                    // 점수 텍스트 업데이트 (예: "(3.5 점)")
	                    currentRatingSpan.textContent = `(${currentRating.toFixed(1)} 점)`; // toFixed(1): 소수점 첫째 자리까지 표시

	                    // hidden input 필드의 value 속성에 선택된 점수 값을 설정 (이 값이 서버로 전송됨)
	                    ratingValueInput.value = currentRating;

	                    // (개발 확인용) 콘솔에 로그 출력
	                    console.log('별점 선택됨:', ratingValueInput.value);
	                });

	                // --- (선택 사항) 마우스 오버 효과 ---
	                star.addEventListener('mouseover', function() {
	                    // 마우스가 올라간 별의 data-value 값을 가져옴
	                    const hoverValue = parseFloat(this.dataset.value);
	                    // 별 모양을 마우스 위치 기준으로 임시 업데이트 (클릭 전 미리보기 효과)
	                    updateStars(hoverValue);
	                });

	                // --- (선택 사항) 마우스 아웃 효과 ---
	                star.addEventListener('mouseout', function() {
	                    // 마우스가 별 영역 밖으로 나가면, 최종 클릭된(currentRating) 상태로 별 모양 복구
	                    updateStars(currentRating);
	                });
	            });

	            // (참고) 페이지 로딩 시 초기 별점 설정 (만약 수정 기능을 구현한다면 필요)
	            // const initialRating = parseFloat(ratingValueInput.value || '0');
	            // if (initialRating > 0) {
	            //     currentRating = initialRating;
	            //     updateStars(currentRating);
	            //     currentRatingSpan.textContent = `(${currentRating.toFixed(1)} 점)`;
	            // }
	            // 현재는 새로 리뷰를 작성하는 경우만 가정하므로 위 코드는 주석 처리합니다.
	        });
		</script>