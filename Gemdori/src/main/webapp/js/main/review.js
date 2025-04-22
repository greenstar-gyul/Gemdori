/**
 * 
 */

// ============================================
// ▼▼▼ 전역 변수 선언 ▼▼▼
// ============================================
// 현재 로그인한 사용자의 userCode (없으면 빈 문자열)
// (주의!) EL 3.0 이상에서만 ?. 연산자 사용 가능. 하위 버전이면 c:choose 또는 스크립틀릿 사용 필요.

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

				console.log(`⭐ ${rating} vs ${starValue}`); // ← 추가

				starIcon.classList.remove(faFull, faHalf, faEmpty);
				if (rating >= starValue) {
					starIcon.classList.add(faFull);
				} else if (rating >= starValue - 0.5) {
					starIcon.classList.add(faHalf);
				} else {
					starIcon.classList.add(faEmpty);
				}
			});
		}

		stars.forEach(star => {
			star.addEventListener('mousemove', function (e) {
				const rect = this.getBoundingClientRect();
				const offsetX = e.clientX - rect.left;
				const percent = offsetX / rect.width;
				const baseValue = parseFloat(this.dataset.value);
				const hoverValue = percent < 0.5 ? baseValue - 0.5 : baseValue;
				updateStars(hoverValue);
			});
			
			star.addEventListener('click', function(e) {
				const rect = this.getBoundingClientRect();
				const isLeftHalf = e.clientX < rect.left + rect.width / 2;
				const baseValue = parseFloat(this.dataset.value);
				currentRating = isLeftHalf ? baseValue - 0.5 : baseValue;

				updateStars(currentRating);
				currentRatingSpan.textContent = `(${currentRating.toFixed(1)} 점)`;
				ratingValueInput.value = currentRating;
			});
			star.addEventListener('mouseover', function(e) {
				const rect = this.getBoundingClientRect();
				const isLeft = e.clientX < rect.left + rect.width / 2;
				const hoverValue = parseFloat(this.dataset.value) - (isLeft ? 0.5 : 0.0);
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

	fetch(`reviewList.do?gameCode=${gameCode}`)
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
                            <button class="review-delete-btn" onclick="deleteReview(event)" value="${review.reviewCode}">
                                <i class="fa fa-trash"></i> 삭제
                            </button>
                        `;
				}

				function escapeHtml(unsafe) {
					if (!unsafe) return ''; // null이나 undefined 처리
					return unsafe
						.replace(/&/g, "&amp;")
						.replace(/</g, "&lt;")
						.replace(/>/g, "&gt;")
						.replace(/"/g, "&quot;")
						.replace(/'/g, "&apos;");
				}

				// 리뷰 HTML 구조 생성
				reviewElement.innerHTML = `
						<input type="hidden" value="${review.reviewCode}" name="reviewCode" id=${review.reviewCode}>
                        <div class="gemdori__review__item__pic">
						<img src="${review.userImage ? contextPath + '/img/' + review.userImage : contextPath + '/img/profile_img.png'}">
                        </div>
                        <div class="gemdori__review__item__text">
                            <h6>
                            
                                 ${review.userName} - <span><fmt:formatDate value='${review.writeDate}' pattern="yyyy-MM-dd HH:mm"/></span>
                                ${deleteButtonHtml}
                            </h6>
                            <div class="star-rating">
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





// --- 리뷰 삭제 함수 ---
function deleteReview(e) {
	let reviewCode = e.currentTarget.value;
	console.log('reviewCode: ' + reviewCode);
	if (!reviewCode) {
		console.error('삭제할 리뷰 코드가 없습니다.');
		return;
	}
	if (!confirm('정말 이 리뷰를 삭제하시겠습니까?')) {
		return;
	}
	const formData = new URLSearchParams();
	formData.append("reviewCode", reviewCode);

	fetch(`${contextPath}/removeReview.do`, {
		method: 'POST',
		headers: {
			"Content-Type": "application/x-www-form-urlencoded"
		},
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
