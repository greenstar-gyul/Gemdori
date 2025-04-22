<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- JSTL 사용을 위한 태그 라이브러리 선언 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
  <head>
    <title>결제하기 - 젬도리</title>
    <%-- 토스페이먼츠 결제창 SDK 추가 --%>
    <script src="https://js.tosspayments.com/v2/standard"></script>
    <%-- 필요한 다른 CSS/JS 파일들을 여기에 추가 --%>
    <style>
      /* 간단한 스타일 예시 */
      body { font-family: sans-serif; }
      section { border: 1px solid #eee; padding: 20px; max-width: 600px; margin: 20px auto; }
      h1, h2 { text-align: center; }
      ul { list-style: none; padding: 0; }
      li { margin-bottom: 10px; padding-bottom: 10px; border-bottom: 1px dashed #eee; display: flex; align-items: center;}
      li:last-child { border-bottom: none; }
      li img { width: 60px; height: auto; margin-right: 10px; } /* 게임 이미지 표시용 */
      .item-details { flex-grow: 1; }
      .item-price { font-weight: bold; margin-left: 10px; min-width: 80px; text-align: right; }
      .original-price { text-decoration: line-through; color: #999; font-size: 0.9em; margin-left: 5px;} /* 원가 표시용 */
      hr { border: 0; border-top: 1px solid #ccc; margin: 20px 0; }
      .summary span { display: inline-block; min-width: 120px; margin-bottom: 5px; }
      .summary .amount { font-weight: bold; text-align: right; float: right; } /* 금액 오른쪽 정렬 */
      .summary .final-amount { color: #d9534f; font-size: 1.2em; } /* 최종 금액 강조 */
      .clear { clear: both; } /* float 해제용 */
      button { display: block; width: 100%; padding: 15px; font-size: 18px; cursor: pointer; background-color: #337ab7; color: white; border: none; border-radius: 5px; margin-top: 20px; }
      button:hover { background-color: #286090; }
    </style>
  </head>
  <body>
    <h1>결제 페이지</h1>

    <section>
      <h2>주문 게임 정보</h2>
      <%-- 컨트롤러에서 전달받은 cartItems (GemdoriShoppingCartVO 리스트) 반복 출력 --%>
      <ul>
        <c:forEach var="item" items="${cartItems}">
          <li>
            <%-- 게임 메인 이미지 표시 (gameMainImage 필드 사용) --%>
            <c:if test="${not empty item.gameMainImage}">
              <img src="${item.gameMainImage}" alt="${item.gameTitle} 이미지">
            </c:if>
            <div class="item-details">
              ${item.gameTitle} <%-- 게임 제목 --%>
              <c:if test="${not empty item.editionName}">
                <span style="color: #555; font-size: 0.9em;">(${item.editionName})</span> <%-- 에디션명 (있으면 표시) --%>
              </c:if>
              <%-- 수량 정보가 있다면 여기에 표시 (예: ${item.cartCnt}개) --%>
            </div>
            <div class="item-price">
                <%-- 할인가(gameSalePrice)가 있으면 할인가를 표시, 원가(gamePrice)에 취소선 표시 --%>
                <c:choose>
                    <c:when test="${not empty item.gameSalePrice && item.gameSalePrice < item.gamePrice}">
                        <fmt:formatNumber value="${item.gameSalePrice}" type="currency" currencySymbol="₩"/>
                        <span class="original-price"><fmt:formatNumber value="${item.gamePrice}" type="currency" currencySymbol="₩"/></span>
                    </c:when>
                    <c:otherwise>
                         <%-- 할인이 없거나 할인가 정보가 없으면 원가(gamePrice)만 표시 --%>
                        <fmt:formatNumber value="${item.gamePrice}" type="currency" currencySymbol="₩"/>
                    </c:otherwise>
                </c:choose>
            </div>
          </li>
        </c:forEach>
      </ul>
      <hr>

      <h2>결제 금액</h2>
      <div class="summary">
        <%-- 컨트롤러에서 계산된 총액 정보 출력 --%>
        <span>총 상품 금액</span>
        <span class="amount"><fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₩ "/></span> <br class="clear">
        <span>총 할인 금액</span>
        <span class="amount"><fmt:formatNumber value="${discountAmount}" type="currency" currencySymbol="₩ "/></span> <br class="clear">
        <hr style="border-top: 1px solid #eee; margin: 10px 0;">
        <span>최종 결제 금액</span>
        <%-- 이 금액이 실제로 토스페이먼츠로 전달되는 금액(${paymentAmount})과 일치해야 함 --%>
        <span class="amount final-amount"><fmt:formatNumber value="${paymentAmount}" type="currency" currencySymbol="₩ "/></span> <br class="clear">
      </div>

      <%-- 결제 버튼 --%>
      <%-- 버튼 텍스트에도 최종 결제 금액 표시 (쉼표 없이 숫자만) --%>
      <button id="payment-button"><fmt:formatNumber value="${paymentAmount}" type="number" groupingUsed="false"/>원 결제하기</button>
    </section>

    <script>
      // 컨트롤러에서 전달된 값들을 JavaScript 변수로 받음 (JSP EL 사용)
      var clientKey = '${tossClientKey}'; // 테스트 클라이언트 키
      var tossPayments = TossPayments(clientKey); // 토스페이먼츠 객체 초기화

      var button = document.getElementById('payment-button'); // '결제하기' 버튼 DOM 요소 가져오기

      // 버튼 클릭 시 토스페이먼츠 결제 요청 함수 실행
      button.addEventListener('click', function () {
        // 최종 결제 금액 확인 (0원 또는 100원 미만 결제 방지 - 클라이언트 측 추가 검증)
        var amountToPay = ${paymentAmount};
        if (amountToPay <= 0) {
          alert("결제할 금액이 없습니다.");
          return;
        }
        // 토스페이먼츠 최소 결제 금액 정책 확인 필요 (일반적으로 100원)
        if (amountToPay < 100) {
             alert("최소 결제 금액은 100원입니다.");
             return;
        }

        // 컨트롤러에서 받은 동적 값들을 사용하여 결제 정보 객체 생성
        var paymentData = {
          amount: amountToPay,                   // 최종 결제 금액 (컨트롤러에서 계산된 값)
          orderId: '${paymentOrderId}',          // 고유 주문번호 (컨트롤러에서 생성된 값)
          orderName: '${paymentOrderName}',      // 주문명 (컨트롤러에서 생성된 값)
          customerName: '${paymentCustomerName}',// 고객명 (컨트롤러에서 가져온 값)
          successUrl: '${paymentSuccessUrl}',    // 결제 성공 시 이동할 URL (컨트롤러에서 생성된 값)
          failUrl: '${paymentFailUrl}',          // 결제 실패 시 이동할 URL (컨트롤러에서 생성된 값)
          // windowTarget: 'iframe', // 결제창을 iframe으로 띄울 경우 (선택 사항)
          // ... 기타 필요한 옵션들 ...
        };

        console.log("결제 요청 데이터:", paymentData); // 디버깅을 위해 콘솔에 결제 정보 출력

        // '카드' 결제 방식으로 결제창 호출
        tossPayments.requestPayment('카드', paymentData)
          .catch(function (error) {
            // 결제창 호출 과정 또는 결제 중 에러 발생 시 처리
            console.error('결제 요청 또는 진행 중 에러:', error);
            alert('결제 중 오류가 발생했습니다: ' + error.message);
          });
      });
    </script>
  </body>
</html>