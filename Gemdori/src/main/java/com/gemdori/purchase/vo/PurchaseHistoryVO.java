package com.gemdori.purchase.vo;

import lombok.Data;

/**
 * 구매 내역 정보를 담는 VO 클래스
 */
@Data
public class PurchaseHistoryVO {
    private String purchaseCode;    // 구매 코드 (P0000001 형식)
    private String userCode;        // 구매자 코드
    private String gameCode;        // 게임 코드
    private String recipientCode;   // 선물 받는 사람 코드 (선물 시)
    private String purchaseDate;    // 구매 일자 (yyyy-MM-dd HH:mm:ss 형식)
    private int price;              // 구매 가격
    private int discountRate;       // 할인율
    private String paymentMethod;   // 결제 수단
    private int purchaseStatus;     // 구매 상태 (1: 완료, 0: 취소 등)
    
    // 조인 조회 시 필요한 게임 정보
    private String gameTitle;       // 게임 제목
    private String thumbnailImage;  // 게임 썸네일 이미지 경로
}