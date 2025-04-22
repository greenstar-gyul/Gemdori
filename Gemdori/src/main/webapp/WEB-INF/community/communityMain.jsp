<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Normal Breadcrumb Begin -->
<section class="normal-breadcrumb set-bg" data-setbg="img/gemdoribg.png">
  <div class="container">
    <div class="row">
      <div class="col-lg-12 text-center">
        <div class="normal__breadcrumb__text">
          <h2>커뮤니티</h2>
          <p>겜도리 공식 커뮤니티</p>
        </div>
      </div>
    </div>
  </div>
</section>
<!-- Normal Breadcrumb End -->

<!-- Blog Section Begin -->
<section class="blog spad">
  <div class="container">
    <div class="row">
        <input type="text" id="gameSearchInput" placeholder="게임명을 입력하세요...">
        <select name="gameCode" id="communityGameSel">
          <c:forEach var="game" items="${gameList}">
            <option value="${game.gameCode}">${game.gameTitle}</option>
          </c:forEach>
        </select>
        <form id="gameForm" action="topicList.do" method="get" style="display: none;">
          <input type="hidden" name="gameCode" id="hiddenGameCode">
        </form>
      <br>
      <div class="col-lg-6">
        <div class="row">
          <c:forEach var="game" items="${popList}" varStatus="status">
            <c:if test="${status.index < 6}">
              <div class="${status.index % 3 == 0 ? 'col-lg-12' : 'col-lg-6 col-md-6 col-sm-6'}">
                <a href="topicList.do?gameCode=${game.gameCode}">
                  <div class="blog__item ${status.index % 3 != 0 ? 'small__item' : ''} set-bg" data-setbg="${game.gameMainImage}">
                    <div class="blog__item__text">
                      <h4>${game.gameTitle}</h4>
                    </div>
                  </div>
                </a>
              </div>
            </c:if>
          </c:forEach>
        </div>
      </div>
      <div class="col-lg-6">
        <div class="row">
          <c:forEach var="game" items="${popList}" varStatus="status">
            <c:if test="${status.index >= 6}">
              <div class="${status.index % 3 == 0 ? 'col-lg-12' : 'col-lg-6 col-md-6 col-sm-6'}">
                <a href="topicList.do?gameCode=${game.gameCode}">
                  <div class="blog__item ${status.index % 3 != 0 ? 'small__item' : ''} set-bg" data-setbg="${game.gameMainImage}">
                    <div class="blog__item__text">
                      <h4>${game.gameTitle}</h4>
                    </div>
                  </div>
                </a>
              </div>
            </c:if>
          </c:forEach>
        </div>
      </div>
    </div>
  </div>
</section>
<!-- Blog Section End -->
<script>
  document.addEventListener('DOMContentLoaded', () => {
    const input = document.getElementById('gameSearchInput');
    const select = document.getElementById('communityGameSel');
    const allOptions = Array.from(select.options);  // 처음 전체 목록 저장

    input.addEventListener('input', () => {
      const keyword = input.value.toLowerCase();

      // 기존 옵션 다 제거
      select.innerHTML = '';

      // 필터링된 옵션 다시 추가
      allOptions.forEach(option => {
        if (option.text.toLowerCase().includes(keyword)) {
          select.appendChild(option.cloneNode(true)); // 복사해서 다시 넣기
        }
      });
    });

    select.addEventListener('change', () => {
      const selectedGameCode = select.value;
      if (selectedGameCode) {
        document.getElementById('hiddenGameCode').value = selectedGameCode;
        document.getElementById('gameForm').submit();
      }
    });
  });

</script>