package com.gemdori.purchase.vo;

import lombok.Data; // Lombok @Data 사용 시 (또는 @Getter, @Setter, @ToString 등)

@Data // Lombok 사용 시 Getter, Setter, toString, EqualsAndHashCode, RequiredArgsConstructor 자동 생성
public class PurchaseHistoryVO {
    private String purchaseCode;     // 구매 고유번호
    private String userCode;         // 구매한 유저
    private String gameCode;         // 구매한 게임
    private String recipientCode;    // 선물 받은 유저 (NULL 가능)
    private String purchaseDate;     // 구매일자 (YYYY-MM-DD HH:MM:SS 형식의 문자열 또는 Date)
    private int price;               // 구매 가격 (할인 적용된 최종 가격)
    private int discountRate;        // 할인율 (%)
    private String paymentMethod;    // 결제 수단 (Toss 응답값 또는 "무료")
    private int purchaseStatus;      // 상태 (1: 정상, 0: 환불처리, -1: 취소)

    // Getter, Setter, toString 등 Lombok이 자동으로 만들어주므로 수동 작성 불필요
}