// searchGame.js - 게임 검색 결과 처리 스크립트
// 기준: searchGames.jsp + SearchGamesControl.java 기반

// DOM 로딩 완료 후 실행
window.addEventListener('DOMContentLoaded', () => {
  // 전역 상태
  let curPage = 1;
  let curSize = 10;

  // 요소 캐시
  const form = document.querySelector('.search-form');
  const summaryBox = document.querySelector('.search-result-summary');
  const listBox = document.querySelector('.list-view');
  const pagination = document.getElementById('pagination');

  const sizeSelect = document.querySelector('#size-select');
  const sortSelect = document.querySelector('#sort-select');

  // 이벤트 연결
  form.addEventListener('submit', e => {
    e.preventDefault();
    curPage = 1;
    doSearch();
  });

  document.querySelectorAll('.filter-select').forEach(sel => {
    sel.addEventListener('change', () => {
      curPage = 1;
      doSearch();
    });
  });


  sizeSelect.addEventListener('change', () => {
    curSize = parseInt(sizeSelect.value, 10);
    curPage = 1;
    // console.log("change!!");
    doSearch();
  });

  sortSelect.addEventListener('change', () => {
    curPage = 1;
    // console.log("change!!");
    doSearch();
  });

  // sizeSelect.dispatchEvent(new Event('change'));

  // console.log(document.querySelector('#size-select'));

  // 검색 실행
  function doSearch() {
    const params = new URLSearchParams(new FormData(form));
    params.set('page', curPage);
    params.set('size', curSize);
    params.set('view', 'list');
    params.set('sort', sortSelect.value || '');
    params.set('ajax', '1');

    fetch(`searchGames.do?${params.toString()}`, {
      headers: { 'Accept': 'application/json' }
    })
        .then(res => res.json())
        .then(data => {
          renderResults(data.items, data.total);
          renderPagination(data.total);
          window.scrollTo({ top: 0, behavior: 'smooth' });
        })
        .catch(err => {
          console.error(err);
          summaryBox.innerHTML = `<p class="text-danger">검색 중 오류가 발생했습니다.</p>`;
        });
  }

  // 결과 출력
  function renderResults(games, totalCount) {
    summaryBox.innerHTML = `<h4>총 ${totalCount}개 검색됨</h4>`;
    listBox.innerHTML = '';

    if (games.length === 0) {
      listBox.innerHTML = `<div class="col-12 text-center py-5 search-no-text">
        <i class="fa fa-search fa-2x mb-2"></i>
        <p>검색 결과가 없습니다.</p>
      </div>`;
      return;
    }

    games.forEach(g => {
      listBox.insertAdjacentHTML('beforeend', listItemTpl(g));
    });

    document.querySelectorAll('.set-bg').forEach(el => {
      el.style.backgroundImage = `url(${el.dataset.setbg})`;
    });
  }

  // 페이지네이션 렌더링
  function renderPagination(totalCount) {
    pagination.innerHTML = '';
    const totalPages = Math.ceil(totalCount / curSize);
    if (totalPages < 2) return;

    const makeBtn = (p, label, arrow = false, disabled = false) => {
      if (disabled) {
        const span = document.createElement('span');
        span.textContent = label;
        span.className = arrow ? 'pagination-item pagination-arrow disabled' : 'pagination-item disabled';
        span.style.opacity = '0.5';
        return span;
      } else {
        const btn = document.createElement('button');
        btn.textContent = label;
        btn.className = arrow ? 'pagination-item pagination-arrow' : 'pagination-item';
        if (p === curPage) btn.classList.add('active');
        btn.addEventListener('click', () => {
          curPage = p;
          doSearch();
        });
        return btn;
      }
    };

    // 이전, 처음
    pagination.appendChild(makeBtn(1, '«', true, curPage === 1));
    pagination.appendChild(makeBtn(curPage - 1, '‹', true, curPage === 1));

    // 숫자 버튼
    for (let p = Math.max(1, curPage - 2); p <= Math.min(totalPages, curPage + 2); p++) {
      pagination.appendChild(makeBtn(p, p.toString()));
    }

    // 다음, 마지막
    pagination.appendChild(makeBtn(curPage + 1, '›', true, curPage === totalPages));
    pagination.appendChild(makeBtn(totalPages, '»', true, curPage === totalPages));
  }

  // 템플릿 함수
  const listItemTpl = g => `
    <a href="gameDetails.do?gameCode=${g.gameCode}">
      <div class="list-item">
        <div class="list-item-img">
          <img src="${g.gameMainImage}" alt="${g.gameTitle}">
        </div>
        <div class="list-item-details">
          <h5 class="list-item-title">
            ${g.gameTitle}
          </h5>
          <div class="list-item-info">
            발매일: ${g.publishingDateStr || '미정'} | 개발사: ${g.gameDeveloper || '정보 없음'}
          </div>
          <div class="list-item-stats">
            <i class="fa fa-star"></i> ${(g.gameRating || 0).toFixed(1)}/10
          </div>
          <div class="list-item-price">
            ${priceText(g.gamePrice)}
          </div>
        </div>
      </div>
    </a>`;

  const priceText = p => (p === 0 ? '무료 플레이' : p.toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' }));

  // 초기 검색 실행
  doSearch();
});
