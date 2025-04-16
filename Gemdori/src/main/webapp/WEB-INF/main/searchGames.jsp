<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
    /* 검색 영역 스타일 */
    .search-container {
        background-color: #0b0c2a;
        padding: 40px 0;
        margin-top: 30px;
        border-radius: 5px;
    }

    .search-box {
        background-color: #1d1e39;
        padding: 30px;
        border-radius: 5px;
        margin-bottom: 30px;
    }

    .search-form {
        display: flex;
        gap: 15px;
    }

    .search-input {
        flex-grow: 1;
        padding: 15px 20px;
        border: none;
        background-color: #151522;
        color: #fff;
        border-radius: 5px;
        font-size: 16px;
    }

    .search-btn {
        background-color: #e53637;
        color: white;
        border: none;
        padding: 0 25px;
        border-radius: 5px;
        cursor: pointer;
        font-weight: 600;
        transition: all 0.3s;
    }

    .search-btn:hover {
        background-color: #ff4a4a;
    }

    .search-filters {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        margin-top: 20px;
    }

    .filter-item {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 10px;
    }

    .filter-item label {
        color: #b7b7b7;
        font-size: 14px;
        margin-right: 5px;
    }

    .filter-select {
        background-color: #151522;
        color: #fff;
        border: 1px solid rgba(255, 255, 255, 0.1);
        padding: 8px 15px;
        border-radius: 5px;
    }

    /* 뷰 전환 버튼 */
    .view-switch {
        display: flex;
        gap: 10px;
        margin-bottom: 20px;
    }

    .view-btn {
        background-color: #1d1e39;
        border: none;
        padding: 8px 15px;
        border-radius: 5px;
        color: #b7b7b7;
        cursor: pointer;
        transition: all 0.3s;
    }

    .view-btn.active {
        background-color: #e53637;
        color: white;
    }

    /* 결과 정렬 */
    .result-sorting {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .sort-options {
    	color : black;
        display: flex;
        gap: 10px;
        align-items: center;
    }

    .display-count {
        display: flex;
        gap: 10px;
        align-items: center;
    }

    .count-btn {
        background-color: #1d1e39;
        border: none;
        padding: 5px 10px;
        border-radius: 5px;
        color: #b7b7b7;
        cursor: pointer;
        transition: all 0.3s;
        font-size: 13px;
    }

    .count-btn.active {
        background-color: #e53637;
        color: white;
    }

    /* 그리드 뷰 스타일 */
    .grid-view {
        display: block;
    }

    /* 리스트 뷰 스타일 */
    .list-view {
        display: none;
    }

    .list-item {
        display: flex;
        background-color: #1d1e39;
        border-radius: 5px;
        padding: 15px;
        margin-bottom: 15px;
        transition: all 0.3s;
    }

    .list-item:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    }

    .list-item-img {
        width: 120px;
        height: 150px;
        border-radius: 5px;
        overflow: hidden;
        margin-right: 20px;
    }

    .list-item-img img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .list-item-details {
        flex-grow: 1;
    }

    .list-item-title {
        color: #ffffff;
        font-size: 18px;
        margin-bottom: 5px;
    }

    .list-item-info {
        margin-bottom: 10px;
        color: #b7b7b7;
    }

    .list-item-tags {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        margin-bottom: 15px;
    }

    .tag {
        background: rgba(255, 255, 255, 0.1);
        color: #b7b7b7;
        padding: 3px 8px;
        border-radius: 20px;
        font-size: 12px;
    }

    .list-item-stats {
        display: flex;
        gap: 15px;
        color: #b7b7b7;
        font-size: 13px;
    }

    .list-item-stat {
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .list-item-price {
        font-size: 18px;
        font-weight: 600;
        color: #e53637;
        display: flex;
        justify-content: flex-end;
        margin-top: 10px;
    }

    /* 페이지네이션 */
    .pagination {
        display: flex;
        justify-content: center;
        margin-top: 40px;
        gap: 5px;
    }

    .pagination-item {
        width: 36px;
        height: 36px;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #1d1e39;
        color: #b7b7b7;
        border-radius: 5px;
        cursor: pointer;
        transition: all 0.3s;
    }

    .pagination-item.active {
        background-color: #e53637;
        color: white;
    }

    .pagination-item:hover:not(.active) {
        background-color: #151522;
    }

    .pagination-arrow {
        font-size: 14px;
    }

    /* 추가 스타일 - 여백 조절 */
    .top-spacing {
        margin-top: 80px;
    }

    .no-results {
        text-align: center;
        padding: 50px 20px;
        color: #b7b7b7;
    }

    .no-results i {
        font-size: 48px;
        color: #e53637;
        margin-bottom: 20px;
    }

    .no-results h4 {
        margin-bottom: 15px;
        color: white;
    }
</style>

<!-- 검색 영역 -->
<section class="search-container top-spacing">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="search-box">
                    <form class="search-form">
                        <input type="text" class="search-input" placeholder="게임이나 키워드를 검색해보세요..." value="${param.keyword}">
                        <button type="submit" class="search-btn">검색</button>
                    </form>
                    
                    <div class="search-filters">
                        <div class="filter-item">
                            <label>장르:</label>
                            <select class="filter-select">
                                <option value="">전체</option>
                                <option value="action">액션</option>
                                <option value="rpg">RPG</option>
                                <option value="strategy">전략</option>
                                <option value="adventure">어드벤처</option>
                                <option value="fps">FPS</option>
                                <option value="simulation">시뮬레이션</option>
                                <option value="horror">공포</option>
                                <option value="puzzle">퍼즐</option>
                            </select>
                        </div>
                        <div class="filter-item">
                            <label>가격대:</label>
                            <select class="filter-select">
                                <option value="">전체</option>
                                <option value="free">무료</option>
                                <option value="under20000">2만원 미만</option>
                                <option value="under40000">4만원 미만</option>
                                <option value="under60000">6만원 미만</option>
                                <option value="over60000">6만원 이상</option>
                            </select>
                        </div>
                        <div class="filter-item">
                            <label>출시일:</label>
                            <select class="filter-select">
                                <option value="">전체</option>
                                <option value="week">1주일 이내</option>
                                <option value="month">1개월 이내</option>
                                <option value="year">1년 이내</option>
                            </select>
                        </div>
                        <div class="filter-item">
                            <label>평점:</label>
                            <select class="filter-select">
                                <option value="">전체</option>
                                <option value="9">9점 이상</option>
                                <option value="8">8점 이상</option>
                                <option value="7">7점 이상</option>
                                <option value="6">6점 이상</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 검색 결과 영역 -->
<section class="search-results spad">
    <div class="container">
        <div class="row">
            <!-- 사이드 영역-->
            <div class="col-lg-4 col-md-6 col-sm-8">
                <div class="category__sidebar" style="position: sticky; top: 80px;">

                    <!-- 카테고리 박스 -->
                    <div class="category__box">
                        <div class="section-title">
                            <h5>카테고리</h5>
                        </div>
                        <ul class="category__list">
                            <li><a href="./searchGames.jsp?genre=action">액션</a></li>
                            <li><a href="./searchGames.jsp?genre=rpg">RPG</a></li>
                            <li><a href="./searchGames.jsp?genre=strategy">전략</a></li>
                            <li><a href="./searchGames.jsp?genre=adventure">어드벤처</a></li>
                            <li><a href="./searchGames.jsp?genre=fps">FPS</a></li>
                            <li><a href="./searchGames.jsp?genre=simulation">시뮬레이션</a></li>
                            <li><a href="./searchGames.jsp?genre=horror">공포</a></li>
                            <li><a href="./searchGames.jsp?genre=puzzle">퍼즐</a></li>
                        </ul>
                    </div>
                    
                    <!-- 즐겨찾기 박스 -->
                    <div class="favorite__box" style="margin-top: 20px;">
                        <div class="section-title">
                            <h5>내 관심 게임</h5>
                        </div>
                        <div class="row g-2">
                            <div class="col-6">
                                <div class="favorite__item">
                                    <a href="gamePackage.do"><img src="img/popular/popular-4.jpg">
                                        <p>엘든 링</p>
                                    </a>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="favorite__item">
                                    <a href="#"><img src="img/popular/popular-1.jpg">
                                        <p>디아블로 4</p>
                                    </a>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="favorite__item">
                                    <a href="#"><img src="img/popular/popular-2.jpg">
                                        <p>스타필드</p>
                                    </a>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="favorite__item">
                                    <a href="#"><img src="img/popular/popular-3.jpg">
                                        <p>발더스 게이트 3</p>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 메인 검색 결과 영역 -->
            <div class="col-lg-8">
                <!-- 검색 결과 개요 -->
                <div class="search-result-summary">
                    <h4>"${param.keyword}" 검색 결과 (총 28개)</h4>
                </div>

                <!-- 뷰 전환 및 정렬 옵션 -->
                <div class="result-sorting">
                    <div class="view-switch">
                        <button id="grid-view-btn" class="view-btn active">
                            <i class="fa fa-th-large"></i> 그리드
                        </button>
                        <button id="list-view-btn" class="view-btn">
                            <i class="fa fa-list"></i> 리스트
                        </button>
                    </div>
                    <div class="sort-options">
                        <label style="color: #b7b7b7; margin-right: 10px;">정렬:</label>
                        <select class="filter-select">
                            <option value="relevance">관련성</option>
                            <option value="newest">최신순</option>
                            <option value="rating">평점순</option>
                            <option value="price_low">가격 낮은순</option>
                            <option value="price_high">가격 높은순</option>
                        </select>
                    </div>
                </div>

                <!-- 결과 표시 개수 설정 -->
                <div class="display-count" style="margin-bottom: 20px;">
                    <label style="color: #b7b7b7;">표시:</label>
                    <button class="count-btn active">9</button>
                    <button class="count-btn">18</button>
                    <button class="count-btn">27</button>
                </div>

                <!-- 그리드 뷰 (기본 보기) -->
                <div class="grid-view">
                    <div class="row">
                        <!-- 게임 아이템 1 -->
                        <div class="col-lg-4 col-md-6 col-sm-6">
                            <div class="product__item">
                                <div class="product__item__pic set-bg" data-setbg="img/trending/trend-1.jpg">
                                    <div class="ep">9.5/10</div>
                                    <div class="comment"><i class="fa fa-comments"></i> 32</div>
                                    <div class="view"><i class="fa fa-eye"></i> 9,541</div>
                                </div>
                                <div class="product__item__text">
                                    <ul>
                                        <li>FPS</li>
                                        <li>슈팅</li>
                                        <li>멀티플레이</li>
                                    </ul>
                                    <h5><a href="gamePackage.do">카운터 스트라이크 2</a></h5>
                                </div>
                            </div>
                        </div>
                        <!-- 게임 아이템 2 -->
                        <div class="col-lg-4 col-md-6 col-sm-6">
                            <div class="product__item">
                                <div class="product__item__pic set-bg" data-setbg="img/trending/trend-2.jpg">
                                    <div class="ep">8.8/10</div>
                                    <div class="comment"><i class="fa fa-comments"></i> 24</div>
                                    <div class="view"><i class="fa fa-eye"></i> 7,381</div>
                                </div>
                                <div class="product__item__text">
                                    <ul>
                                        <li>서바이벌</li>
                                        <li>슈팅</li>
                                        <li>배틀로얄</li>
                                    </ul>
                                    <h5><a href="#">PUBG: 배틀그라운드</a></h5>
                                </div>
                            </div>
                        </div>
                        <!-- 게임 아이템 3 -->
                        <div class="col-lg-4 col-md-6 col-sm-6">
                            <div class="product__item">
                                <div class="product__item__pic set-bg" data-setbg="img/trending/trend-3.jpg">
                                    <div class="ep">9.2/10</div>
                                    <div class="comment"><i class="fa fa-comments"></i> 18</div>
                                    <div class="view"><i class="fa fa-eye"></i> 6,982</div>
                                </div>
                                <div class="product__item__text">
                                    <ul>
                                        <li>헌팅</li>
                                        <li>액션</li>
                                        <li>멀티플레이</li>
                                    </ul>
                                    <h5><a href="#">몬스터 헌터 와일즈</a></h5>
                                </div>
                            </div>
                        </div>
                        <!-- 게임 아이템 4 -->
                        <div class="col-lg-4 col-md-6 col-sm-6">
                            <div class="product__item">
                                <div class="product__item__pic set-bg" data-setbg="img/trending/trend-4.jpg">
                                    <div class="ep">8.5/10</div>
                                    <div class="comment"><i class="fa fa-comments"></i> 14</div>
                                    <div class="view"><i class="fa fa-eye"></i> 5,243</div>
                                </div>
                                <div class="product__item__text">
                                    <ul>
                                        <li>인벤토리 관리</li>
                                        <li>멀티플레이</li>
                                        <li>2D</li>
                                        <li>로그라이트</li>
                                    </ul>
                                    <h5><a href="#">세피리아</a></h5>
                                </div>
                            </div>
                        </div>
                        <!-- 게임 아이템 5 -->
                        <div class="col-lg-4 col-md-6 col-sm-6">
                            <div class="product__item">
                                <div class="product__item__pic set-bg" data-setbg="img/trending/trend-5.jpg">
                                    <div class="ep">7.9/10</div>
                                    <div class="comment"><i class="fa fa-comments"></i> 8</div>
                                    <div class="view"><i class="fa fa-eye"></i> 3,562</div>
                                </div>
                                <div class="product__item__text">
                                    <ul>
                                        <li>얼리 액세스</li>
                                        <li>서바이벌</li>
                                        <li>좀비</li>
                                        <li>공포</li>
                                    </ul>
                                    <h5><a href="#">인투 더 데드: 아워 다크니스 데이즈</a></h5>
                                </div>
                            </div>
                        </div>
                        <!-- 게임 아이템 6 -->
                        <div class="col-lg-4 col-md-6 col-sm-6">
                            <div class="product__item">
                                <div class="product__item__pic set-bg" data-setbg="img/trending/trend-6.jpg">
                                    <div class="ep">8.3/10</div>
                                    <div class="comment"><i class="fa fa-comments"></i> 22</div>
                                    <div class="view"><i class="fa fa-eye"></i> 8,125</div>
                                </div>
                                <div class="product__item__text">
                                    <ul>
                                        <li>무료 플레이</li>
                                        <li>애니메이션</li>
                                        <li>멀티플레이</li>
                                        <li>MOBA</li>
                                        <li>PvP</li>
                                    </ul>
                                    <h5><a href="#">이터널 리턴</a></h5>
                                </div>
                            </div>
                        </div>
                        <!-- 게임 아이템 7 -->
                        <div class="col-lg-4 col-md-6 col-sm-6">
                            <div class="product__item">
                                <div class="product__item__pic set-bg" data-setbg="img/popular/popular-1.jpg">
                                    <div class="ep">9.4/10</div>
                                    <div class="comment"><i class="fa fa-comments"></i> 42</div>
                                    <div class="view"><i class="fa fa-eye"></i> 11,763</div>
                                </div>
                                <div class="product__item__text">
                                    <ul>
                                        <li>RPG</li>
                                        <li>오픈월드</li>
                                        <li>판타지</li>
                                    </ul>
                                    <h5><a href="#">엘든 링</a></h5>
                                </div>
                            </div>
                        </div>
                        <!-- 게임 아이템 8 -->
                        <div class="col-lg-4 col-md-6 col-sm-6">
                            <div class="product__item">
                                <div class="product__item__pic set-bg" data-setbg="img/popular/popular-2.jpg">
                                    <div class="ep">9.0/10</div>
                                    <div class="comment"><i class="fa fa-comments"></i> 31</div>
                                    <div class="view"><i class="fa fa-eye"></i> 9,876</div>
                                </div>
                                <div class="product__item__text">
                                    <ul>
                                        <li>액션</li>
                                        <li>RPG</li>
                                        <li>사이버펑크</li>
                                    </ul>
                                    <h5><a href="#">사이버펑크 2077</a></h5>
                                </div>
                            </div>
                        </div>
                        <!-- 게임 아이템 9 -->
                        <div class="col-lg-4 col-md-6 col-sm-6">
                            <div class="product__item">
                                <div class="product__item__pic set-bg" data-setbg="img/popular/popular-3.jpg">
                                    <div class="ep">9.6/10</div>
                                    <div class="comment"><i class="fa fa-comments"></i> 54</div>
                                    <div class="view"><i class="fa fa-eye"></i> 13,421</div>
                                </div>
                                <div class="product__item__text">
                                    <ul>
                                        <li>RPG</li>
                                        <li>턴제</li>
                                        <li>판타지</li>
                                    </ul>
                                    <h5><a href="#">발더스 게이트 3</a></h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 리스트 뷰 (처음에는 숨겨져 있음) -->
                <div class="list-view">
                    <!-- 리스트 아이템 1 -->
                    <div class="list-item">
                        <div class="list-item-img">
                            <img src="img/trending/trend-1.jpg" alt="카운터 스트라이크 2">
                        </div>
                        <div class="list-item-details">
                            <h5 class="list-item-title">카운터 스트라이크 2</h5>
                            <div class="list-item-info">발매일: 2023.09.27 | 개발사: Valve</div>
                            <div class="list-item-tags">
                                <span class="tag">FPS</span>
                                <span class="tag">슈팅</span>
                                <span class="tag">멀티플레이</span>
                                <span class="tag">e스포츠</span>
                                <span class="tag">전략</span>
                            </div>
                            <div class="list-item-stats">
                                <div class="list-item-stat"><i class="fa fa-star"></i> 9.5/10</div>
                                <div class="list-item-stat"><i class="fa fa-eye"></i> 9,541</div>
                                <div class="list-item-stat"><i class="fa fa-comments"></i> 32</div>
                            </div>
                            <div class="list-item-price">무료 플레이</div>
                        </div>
                    </div>
                    <!-- 리스트 아이템 2 -->
                    <div class="list-item">
                        <div class="list-item-img">
                            <img src="img/trending/trend-2.jpg" alt="PUBG: 배틀그라운드">
                        </div>
                        <div class="list-item-details">
                            <h5 class="list-item-title">PUBG: 배틀그라운드</h5>
                            <div class="list-item-info">발매일: 2017.12.21 | 개발사: PUBG Studios</div>
                            <div class="list-item-tags">
                                <span class="tag">서바이벌</span>
                                <span class="tag">슈팅</span>
                                <span class="tag">배틀로얄</span>
                                <span class="tag">액션</span>
                                <span class="tag">멀티플레이</span>
                            </div>
                            <div class="list-item-stats">
                                <div class="list-item-stat"><i class="fa fa-star"></i> 8.8/10</div>
                                <div class="list-item-stat"><i class="fa fa-eye"></i> 7,381</div>
                                <div class="list-item-stat"><i class="fa fa-comments"></i> 24</div>
                            </div>
                            <div class="list-item-price">16,000원</div>
                        </div>
                    </div>
                    <!-- 리스트 아이템 3 -->
                    <div class="list-item">
                        <div class="list-item-img">
                            <img src="img/trending/trend-3.jpg" alt="몬스터 헌터 와일즈">
                        </div>
                        <div class="list-item-details">
                            <h5 class="list-item-title">몬스터 헌터 와일즈</h5>
                            <div class="list-item-info">발매일: 2025.02.28 | 개발사: 캡콤</div>
                            <div class="list-item-tags">
                                <span class="tag">헌팅</span>
                                <span class="tag">액션</span>
                                <span class="tag">멀티플레이</span>
                                <span class="tag">오픈월드</span>
                                <span class="tag">판타지</span>
                            </div>
                            <div class="list-item-stats">
                                <div class="list-item-stat"><i class="fa fa-star"></i> 9.2/10</div>
                                <div class="list-item-stat"><i class="fa fa-eye"></i> 6,982</div>
                                <div class="list-item-stat"><i class="fa fa-comments"></i> 18</div>
                            </div>
                            <div class="list-item-price">68,000원</div>
                        </div>
                    </div>
                    <!-- 리스트 아이템 4 -->
                    <div class="list-item">
                        <div class="list-item-img">
                            <img src="img/trending/trend-4.jpg" alt="세피리아">
                        </div>
                        <div class="list-item-details">
                            <h5 class="list-item-title">세피리아</h5>
                            <div class="list-item-info">발매일: 2024.03.15 | 개발사: 인디 게임즈</div>
                            <div class="list-item-tags">
                                <span class="tag">인벤토리 관리</span>
                                <span class="tag">멀티플레이</span>
                                <span class="tag">2D</span>
                                <span class="tag">로그라이트</span>
                                <span class="tag">픽셀</span>
                            </div>
                            <div class="list-item-stats">
                                <div class="list-item-stat"><i class="fa fa-star"></i> 8.5/10</div>
                                <div class="list-item-stat"><i class="fa fa-eye"></i> 5,243</div>
                                <div class="list-item-stat"><i class="fa fa-comments"></i> 14</div>
                            </div>
                            <div class="list-item-price">22,000원</div>
                        </div>
                    </div>
                    <!-- 리스트 아이템 5 -->
                    <div class="list-item">
                        <div class="list-item-img">
                            <img src="img/trending/trend-5.jpg" alt="인투 더 데드: 아워 다크니스 데이즈">
                        </div>
                        <div class="list-item-details">
                            <h5 class="list-item-title">인투 더 데드: 아워 다크니스 데이즈</h5>
                            <div class="list-item-info">발매일: 2024.08.22 | 개발사: PikPok</div>
                            <div class="list-item-tags">
                                <span class="tag">얼리 액세스</span>
                                <span class="tag">서바이벌</span>
                                <span class="tag">좀비</span>
                                <span class="tag">공포</span>
                                <span class="tag">액션</span>
                            </div>
                            <div class="list-item-stats">
                                <div class="list-item-stat"><i class="fa fa-star"></i> 7.9/10</div>
                                <div class="list-item-stat"><i class="fa fa-eye"></i> 3,562</div>
                                <div class="list-item-stat"><i class="fa fa-comments"></i> 8</div>
                            </div>
                            <div class="list-item-price">25,000원</div>
                        </div>
                    </div>
                    <!-- 리스트 아이템 6 -->
                    <div class="list-item">
                        <div class="list-item-img">
                            <img src="img/trending/trend-6.jpg" alt="이터널 리턴">
                        </div>
                        <div class="list-item-details">
                            <h5 class="list-item-title">이터널 리턴</h5>
                            <div class="list-item-info">발매일: 2020.10.14 | 개발사: 님블뉴런</div>
                            <div class="list-item-tags">
                                <span class="tag">무료 플레이</span>
                                <span class="tag">애니메이션</span>
                                <span class="tag">멀티플레이</span>
                                <span class="tag">MOBA</span>
                                <span class="tag">PvP</span>
                            </div>
                            <div class="list-item-stats">
                                <div class="list-item-stat"><i class="fa fa-star"></i> 8.3/10</div>
                                <div class="list-item-stat"><i class="fa fa-eye"></i> 8,125</div>
                                <div class="list-item-stat"><i class="fa fa-comments"></i> 22</div>
                            </div>
                            <div class="list-item-price">무료 플레이</div>
                        </div>
                    </div>
                    <!-- 리스트 아이템 7 -->
                    <div class="list-item">
                        <div class="list-item-img">
                            <img src="img/popular/popular-1.jpg" alt="엘든 링">
                        </div>
                        <div class="list-item-details">
                            <h5 class="list-item-title">엘든 링</h5>
                            <div class="list-item-info">발매일: 2022.02.25 | 개발사: 프롬 소프트웨어</div>
                            <div class="list-item-tags">
                                <span class="tag">RPG</span>
                                <span class="tag">오픈월드</span>
                                <span class="tag">판타지</span>
                                <span class="tag">다크 소울류</span>
                                <span class="tag">액션</span>
                            </div>
                            <div class="list-item-stats">
                                <div class="list-item-stat"><i class="fa fa-star"></i> 9.4/10</div>
                                <div class="list-item-stat"><i class="fa fa-eye"></i> 11,763</div>
                                <div class="list-item-stat"><i class="fa fa-comments"></i> 42</div>
                            </div>
                            <div class="list-item-price">64,800원</div>
                        </div>
                    </div>
                    <!-- 리스트 아이템 8 -->
                    <div class="list-item">
                        <div class="list-item-img">
                            <img src="img/popular/popular-2.jpg" alt="사이버펑크 2077">
                        </div>
                        <div class="list-item-details">
                            <h5 class="list-item-title">사이버펑크 2077</h5>
                            <div class="list-item-info">발매일: 2020.12.10 | 개발사: CD 프로젝트 레드</div>
                            <div class="list-item-tags">
                                <span class="tag">RPG</span>
                                <span class="tag">오픈월드</span>
                                <span class="tag">사이버펑크</span>
                                <span class="tag">액션</span>
                                <span class="tag">1인칭</span>
                            </div>
                            <div class="list-item-stats">
                                <div class="list-item-stat"><i class="fa fa-star"></i> 9.0/10</div>
                                <div class="list-item-stat"><i class="fa fa-eye"></i> 9,876</div>
                                <div class="list-item-stat"><i class="fa fa-comments"></i> 31</div>
                            </div>
                            <div class="list-item-price">43,500원</div>
                        </div>
                    </div>
                    <!-- 리스트 아이템 9 -->
                    <div class="list-item">
                        <div class="list-item-img">
                            <img src="img/popular/popular-3.jpg" alt="발더스 게이트 3">
                        </div>
                        <div class="list-item-details">
                            <h5 class="list-item-title">발더스 게이트 3</h5>
                            <div class="list-item-info">발매일: 2023.08.03 | 개발사: Larian Studios</div>
                            <div class="list-item-tags">
                                <span class="tag">RPG</span>
                                <span class="tag">턴제</span>
                                <span class="tag">판타지</span>
                                <span class="tag">던전 앤 드래곤</span>
                                <span class="tag">선택지</span>
                            </div>
                            <div class="list-item-stats">
                                <div class="list-item-stat"><i class="fa fa-star"></i> 9.6/10</div>
                                <div class="list-item-stat"><i class="fa fa-eye"></i> 13,421</div>
                                <div class="list-item-stat"><i class="fa fa-comments"></i> 54</div>
                            </div>
                            <div class="list-item-price">69,800원</div>
                        </div>
                    </div>
                    <!-- 리스트 아이템 10 -->
                    <div class="list-item">
                        <div class="list-item-img">
                            <img src="img/popular/popular-4.jpg" alt="아펙스 레전드">
                        </div>
                        <div class="list-item-details">
                            <h5 class="list-item-title">아펙스 레전드</h5>
                            <div class="list-item-info">발매일: 2019.02.04 | 개발사: 리스폰 엔터테인먼트</div>
                            <div class="list-item-tags">
                                <span class="tag">무료 플레이</span>
                                <span class="tag">배틀로얄</span>
                                <span class="tag">FPS</span>
                                <span class="tag">멀티플레이</span>
                                <span class="tag">슈팅</span>
                            </div>
                            <div class="list-item-stats">
                                <div class="list-item-stat"><i class="fa fa-star"></i> 8.7/10</div>
                                <div class="list-item-stat"><i class="fa fa-eye"></i> 10,342</div>
                                <div class="list-item-stat"><i class="fa fa-comments"></i> 38</div>
                            </div>
                            <div class="list-item-price">무료 플레이</div>
                        </div>
                    </div>
                </div>

                <!-- 페이지네이션 -->
                <div class="pagination">
                    <div class="pagination-item pagination-arrow">
                        <i class="fa fa-angle-double-left"></i>
                    </div>
                    <div class="pagination-item pagination-arrow">
                        <i class="fa fa-angle-left"></i>
                    </div>
                    <div class="pagination-item active">1</div>
                    <div class="pagination-item">2</div>
                    <div class="pagination-item">3</div>
                    <div class="pagination-item">4</div>
                    <div class="pagination-item">5</div>
                    <div class="pagination-item pagination-arrow">
                        <i class="fa fa-angle-right"></i>
                    </div>
                    <div class="pagination-item pagination-arrow">
                        <i class="fa fa-angle-double-right"></i>
                    </div>
                </div>

                <!-- 검색 결과가 없을 때 -->
                <!-- 
                <div class="no-results">
                    <i class="fa fa-search"></i>
                    <h4>"검색어"에 대한 검색 결과가 없습니다.</h4>
                    <p>다른 키워드로 검색하거나 필터를 조정해 보세요.</p>
                </div>
                -->
            </div>
        </div>
    </div>
</section>

<!-- Js 스크립트 - 검색 페이지 기능을 위한 코드 -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    console.log("Document ready");

    // 그리드 뷰와 리스트 뷰 전환
    document.getElementById('grid-view-btn').addEventListener('click', function() {
        console.log("Grid view button clicked");
        this.classList.add('active');
        document.getElementById('list-view-btn').classList.remove('active');
        document.querySelector('.grid-view').style.display = 'block';
        document.querySelector('.list-view').style.display = 'none';
    });

    document.getElementById('list-view-btn').addEventListener('click', function() {
        console.log("List view button clicked");
        this.classList.add('active');
        document.getElementById('grid-view-btn').classList.remove('active');
        document.querySelector('.grid-view').style.display = 'none';
        document.querySelector('.list-view').style.display = 'block';
    });

    // 표시 개수 버튼
    const countBtns = document.querySelectorAll('.count-btn');
    countBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            console.log("Count button clicked");
            countBtns.forEach(b => b.classList.remove('active'));
            this.classList.add('active');
            // 실제 구현 시에는 여기에 AJAX 호출로 결과 개수를 변경하게 됨
        });
    });

    // 페이지네이션
    const paginationItems = document.querySelectorAll('.pagination-item');
    paginationItems.forEach(item => {
        item.addEventListener('click', function() {
            console.log("Pagination item clicked");
            if (!this.classList.contains('pagination-arrow')) {
                paginationItems.forEach(i => i.classList.remove('active'));
                this.classList.add('active');
                // 실제 구현 시에는 여기에 AJAX 호출로 페이지를 변경하게 됨
            }
        });
    });

    // 이미지 배경 설정 (set-bg 클래스 처리)
    const setBgElements = document.querySelectorAll('.set-bg');
    setBgElements.forEach(function(element) {
        var bg = element.getAttribute('data-setbg');
        element.style.backgroundImage = 'url(' + bg + ')';
    });

    console.log("Scripts loaded");
});
</script>