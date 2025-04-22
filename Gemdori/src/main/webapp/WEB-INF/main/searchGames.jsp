<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"       prefix="c"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"        prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"  %>

<!-- ───────── 검색 영역 ───────── -->
  <section class="search-container top-spacing">
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <div class="search-box">
            <form class="search-form" method="get" action="searchGames.do">
              <input
                type="text"
                class="search-input"
                name="keyword"
                value="${param.keyword}"
                placeholder="게임이나 키워드를 검색해보세요..."
              >
              <button type="submit" class="search-btn">검색</button>

              <!-- ── 필터 영역 ── -->
              <div class="search-filters">
                <!-- 장르 -->
                <div class="filter-item">
                  <label>장르:</label>
                  <select class="filter-select" name="genres">
                    <option value="">전체</option>
                    <option value="액션">액션</option>
                    <option value="rpg">RPG</option>
                    <option value="전략">전략</option>
                    <option value="어드벤처">어드벤처</option>
                    <option value="캐주얼">캐주얼</option>
                    <option value="교육">교육</option>
                    <option value="스포츠">스포츠</option>
                    <option value="레이싱">레이싱</option>
                    <option value="인디">인디</option>
                  </select>
                </div>
                <!-- 가격 -->
                <div class="filter-item">
                  <label>가격대:</label>
                  <select class="filter-select" name="prices">
                    <option value="">전체</option>
                    <option value="free">무료</option>
                    <option value="under20000">2만원 미만</option>
                    <option value="under40000">4만원 미만</option>
                    <option value="under60000">6만원 미만</option>
                    <option value="over60000">6만원 이상</option>
                  </select>
                </div>
                <!-- DLC 포함여부 -->
                <div class="filter-item">
                  <label>DLC 보기:</label>
                  <select name="dlc" class="filter-select">
                    <option value="all" selected>전체</option>
                    <option value="origin">DLC 제외</option>
                    <option value="dlc">DLC만 보기</option>
                  </select>
                </div>
                <!-- 평점 -->
                <div class="filter-item">
                  <label>평점:</label>
                  <select class="filter-select" name="rating">
                    <option value="">전체</option>
                    <option value="4">4점 이상</option>
                    <option value="3">3점 이상</option>
                    <option value="2">2점 이상</option>
                    <option value="1">1점 이상</option>
                    <option value="0">1점 미만</option>
                  </select>
                </div>
              </div>
              <!-- /search-filters -->

            </form>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ───────── 결과 영역 ───────── -->
  <section class="search-results spad">
    <div class="container">
      <div class="row">
      	<div class="col-lg-2">
      	</div>

        <!-- =========== 사이드바 =========== -->
        <%--
        <div class="col-lg-4 col-md-6 col-sm-8">
          <div class="category__sidebar" style="position: sticky; top: 80px;">
            <!-- 카테고리 박스 -->
            <div class="category__box">
              <div class="section-title"><h5>카테고리</h5></div>
              <ul class="category__list">
                <li><a href="searchGames.jsp?genre=action">액션</a></li>
                <li><a href="searchGames.jsp?genre=rpg">RPG</a></li>
                <li><a href="searchGames.jsp?genre=strategy">전략</a></li>
                <li><a href="searchGames.jsp?genre=adventure">어드벤처</a></li>
                <li><a href="searchGames.jsp?genre=fps">FPS</a></li>
                <li><a href="searchGames.jsp?genre=simulation">시뮬레이션</a></li>
                <li><a href="searchGames.jsp?genre=horror">공포</a></li>
                <li><a href="searchGames.jsp?genre=puzzle">퍼즐</a></li>
              </ul>
            </div>
            <!-- 즐겨찾기 박스 -->
            <div class="favorite__box" style="margin-top: 20px;">
              <div class="section-title"><h5>내 관심 게임</h5></div>
              <div class="row g-2">
                <div class="col-6">
                  <div class="favorite__item">
                    <a href="gamePackage.do">
                      <img src="img/popular/popular-4.jpg" alt="엘든 링">
                      <p>엘든 링</p>
                    </a>
                  </div>
                </div>
                <div class="col-6">
                  <div class="favorite__item">
                    <a href="#">
                      <img src="img/popular/popular-1.jpg" alt="디아블로 4">
                      <p>디아블로 4</p>
                    </a>
                  </div>
                </div>
                <div class="col-6">
                  <div class="favorite__item">
                    <a href="#">
                      <img src="img/popular/popular-2.jpg" alt="스타필드">
                      <p>스타필드</p>
                    </a>
                  </div>
                </div>
                <div class="col-6">
                  <div class="favorite__item">
                    <a href="#">
                      <img src="img/popular/popular-3.jpg" alt="발더스 게이트 3">
                      <p>발더스 게이트 3</p>
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>--%>

        <!-- =========== 메인 결과 =========== -->
        <div class="col-lg-8">

          <!-- 결과 요약 -->
          <div class="search-result-summary"></div>

          <!-- 정렬 옵션 -->
          <div class="result-options d-flex justify-content-end">
            <div class="sort-options">
              <label for="sort-select">표시:</label>
              <select name="sort" class="result-options-select" id="sort-select">
                <option value="relevance">관련성</option>
                <option value="newest">최신순</option>
                <option value="oldest">오래된순</option>
                <option value="rating">평점순</option>
                <option value="price_low">가격 낮은순</option>
                <option value="price_high">가격 높은순</option>
              </select>
            </div>


          <!-- 표시 개수 지정 -->
          <!--<div class="display-count" style="margin-bottom:20px;">
            <label style="margin-right:10px;">표시:</label>
            <button class="count-btn">9</button>
            <button class="count-btn">18</button>
            <button class="count-btn">27</button>
          </div>-->

            <div class="display-count">
              <label for="size-select">표시:</label>
              <select class="display-size-select" name="size" id="size-select">
                <option value="10" selected>10개</option>
                <option value="20">20개</option>
                <option value="30">30개</option>
              </select>
            </div>
          </div>

          <!-- ===== 리스트 뷰 ===== -->
          <div class="list-view"></div>

          <!-- 페이지네이션 -->
          <div id="pagination" class="pagination"></div>

        </div>
        
        <div class="col-lg-2">
      	</div>
      </div>
    </div>
  </section>

<!-- 스크립트 -->
<script src="<c:url value='/js/main/searchGame.js'/>"></script>
