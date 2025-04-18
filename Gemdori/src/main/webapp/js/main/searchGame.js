/**
 * 검색 결과 동적 로딩 & 뷰 토글
 * 2025‑04‑18
 */
document.addEventListener('DOMContentLoaded', () => {

  /* ---------- 전역 상태 ---------- */
  let curPage = 1;
  let curSize = 9;                       // 한 페이지 표시 개수 기본값
  let curView = 'grid';                  // 'grid' | 'list'

  /* ---------- DOM 캐시 ---------- */
  const form         = document.querySelector('.search-form');
  const gridBtn      = document.getElementById('grid-view-btn');
  const listBtn      = document.getElementById('list-view-btn');
  const gridBox      = document.querySelector('.grid-view .row');
  const listBox      = document.querySelector('.list-view');
  const summaryBox   = document.querySelector('.search-result-summary');
  const pagination   = document.getElementById('pagination');
  const countBtns    = document.querySelectorAll('.display-count .count-btn');
  const sortSelect   = document.querySelector('.sort-options select[name="sort"]');

  /* ---------- 이벤트 바인딩 ---------- */

  // 1) 검색 폼 제출
  form.addEventListener('submit', e => {
    e.preventDefault();
    curPage = 1;
    doSearch();
  });

  // 2) 뷰 토글
  gridBtn.addEventListener('click', () => { curView = 'grid'; updateView(); });
  listBtn.addEventListener('click', () => { curView = 'list'; updateView(); });

  // 3) 표시 개수 변경
  countBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      countBtns.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      curSize = parseInt(btn.textContent, 10);
      curPage = 1;
      doSearch();
    });
  });

  // 4) 정렬 변경
  sortSelect.addEventListener('change', () => {
    curPage = 1;
    doSearch();
  });

  // 5) 필터(select) 변경 시 바로 검색
  document.querySelectorAll('.search-filters .filter-select').forEach(sel => {
    sel.addEventListener('change', () => {
      curPage = 1;
      doSearch();
    });
  });

  /* ---------- 실제 검색 & 렌더링 ---------- */

  function doSearch() {
    const params = new URLSearchParams(new FormData(form));
    params.set('page', curPage);
    params.set('size', curSize);
    params.set('view', curView);
    params.set('sort', sortSelect.value);
    params.set('ajax', '1');   // 컨트롤러에서 JSON 분기 처리용

    fetch(`searchGames.do?${params.toString()}`, {
      headers: { 'Accept': 'application/json' }
    })
    .then(res => res.json())
    .then(data => {
      renderResults(data.items, data.total);
      renderPagination(data.total);
    })
    .catch(err => {
      console.error(err);
      summaryBox.innerHTML = `<p class="text-danger">검색 중 오류가 발생했습니다.</p>`;
    });
  }

  // 결과 찍어내기
  function renderResults(games, totalCount) {
    // 1) summary
    summaryBox.innerHTML = `
      "${form.keyword.value || ''}" 검색 결과 
      ${ totalCount > 0 
          ? `(총 ${totalCount}개)` 
          : `(결과 없음)` }`;

    // 2) 항목
    gridBox.innerHTML = '';
    listBox.innerHTML = '';

    if (games.length === 0) {
      gridBox.insertAdjacentHTML('beforeend', 
        `<div class="col-12 text-center py-5">
           <i class="fa fa-search fa-2x mb-2"></i>
           <p>"${form.keyword.value}"에 대한 검색 결과가 없습니다.</p>
         </div>`);
      return;
    }

    games.forEach(g => {
      gridBox.insertAdjacentHTML('beforeend', gridCardTpl(g));
      listBox.insertAdjacentHTML('beforeend', listItemTpl(g));
    });

    // 3) view 적용
    updateView();

    // 4) 배경 이미지 적용
    document.querySelectorAll('.set-bg').forEach(el => {
      el.style.backgroundImage = `url(${el.dataset.setbg})`;
    });
  }

  // 페이징 UI
  function renderPagination(totalCount) {
    pagination.innerHTML = '';
    const totalPages = Math.ceil(totalCount / curSize);
    if (totalPages < 2) return;

    const makeBtn = (p, txt, isArrow=false) => {
      const btn = document.createElement('button');
      btn.textContent = txt;
      btn.className = isArrow 
        ? 'pagination-item pagination-arrow' 
        : 'pagination-item';
      if (p === curPage) btn.classList.add('active');
      else btn.addEventListener('click', () => {
        curPage = p;
        doSearch();
      });
      return btn;
    };

    // « ‹
    if (curPage > 1) {
      pagination.appendChild(makeBtn(1, '«', true));
      pagination.appendChild(makeBtn(curPage - 1, '‹', true));
    }

    // 숫자 페이지 (현재 ±2 범위)
    const start = Math.max(1, curPage - 2);
    const end   = Math.min(totalPages, curPage + 2);
    for (let p = start; p <= end; p++) {
      pagination.appendChild(makeBtn(p, p.toString()));
    }

    // › »
    if (curPage < totalPages) {
      pagination.appendChild(makeBtn(curPage + 1, '›', true));
      pagination.appendChild(makeBtn(totalPages, '»', true));
    }
  }

  /* ---------- 뷰 토글 헬퍼 ---------- */
  function updateView() {
    if (curView === 'grid') {
      gridBtn.classList.add('active');
      listBtn.classList.remove('active');
      gridBox.parentElement.style.display = '';
      listBox.style.display = 'none';
    } else {
      listBtn.classList.add('active');
      gridBtn.classList.remove('active');
      listBox.style.display = '';
      gridBox.parentElement.style.display = 'none';
    }
  }

  /* ---------- 템플릿 ---------- */
  const gridCardTpl = g => `
    <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
      <div class="product__item">
        <div class="product__item__pic set-bg" data-setbg="${g.gameMainImage}">
          ${ g.gameRating != null
             ? `<div class="ep">${g.gameRating.toFixed(1)}/10</div>` 
             : '' }
        </div>
        <div class="product__item__text">
          <ul>
            <li>${g.gameGenre}</li>
            <li>${g.gameTag}</li>
          </ul>
          <h5>
            <a href="gameDetails.do?gameCode=${g.gameCode}">
              ${g.gameTitle}
            </a>
          </h5>
        </div>
      </div>
    </div>`;

  const listItemTpl = g => `
    <div class="list-item">
      <div class="list-item-img">
        <img src="${g.gameMainImage}" alt="${g.gameTitle}">
      </div>
      <div class="list-item-details">
        <h5 class="list-item-title">
          <a href="gameDetails.do?gameCode=${g.gameCode}">
            ${g.gameTitle}
          </a>
        </h5>
        <div class="list-item-info">
          발매일: ${g.publishingDateStr} | 개발사: ${g.gameDeveloper}
        </div>
        <div class="list-item-tags">
          ${ g.gameTag.split(',').map(tag => `<span class="tag">${tag.trim()}</span>`).join('') }
        </div>
        <div class="list-item-stats">
          <i class="fa fa-star"></i> ${ (g.gameRating || 0).toFixed(1) }/10
        </div>
        <div class="list-item-price">${ priceText(g.gamePrice) }</div>
      </div>
    </div>`;

  const priceText = p => p === 0
    ? '무료 플레이'
    : p.toLocaleString('ko-KR', { style:'currency', currency:'KRW' });

  // 초기 한 번 실행
  doSearch();
});
