package com.gemdori.purchase.service;

import java.util.List;
import com.gemdori.purchase.vo.GemdoriShoppingCartVO; // 장바구니 VO 필요
import com.google.gson.JsonObject; // 또는 다른 JSON 객체 타입

public interface PurchaseHistoryService {

    /**
     * 실제 결제가 완료된 구매 내역을 기록합니다. (Toss 결제 승인 후 호출)
     * 장바구니의 각 상품에 대해 구매 내역을 생성합니다.
     * @param userCode 구매자 코드
     * @param cartItems 구매한 상품 목록 (장바구니 정보)
     * @param tossPaymentData Toss 결제 승인 API 응답 데이터 (JSON 객체 등)
     * @return 모든 내역 등록 성공 시 true, 하나라도 실패 시 false
     * @throws Exception DB 처리 중 예외 발생 시
     */
    boolean recordPaidPurchase(String userCode, List<GemdoriShoppingCartVO> cartItems, JsonObject tossPaymentData) throws Exception;


    /**
     * 0원 결제(무료 구매) 내역을 기록합니다.
     * 장바구니의 각 상품에 대해 구매 내역을 생성합니다.
     * @param userCode 구매자 코드
     * @param orderId 주문 ID (참고용)
     * @param cartItems 구매한 상품 목록 (장바구니 정보)
     * @return 모든 내역 등록 성공 시 true, 하나라도 실패 시 false
     * @throws Exception DB 처리 중 예외 발생 시
     */
    boolean recordFreePurchase(String userCode, String orderId, List<GemdoriShoppingCartVO> cartItems) throws Exception;

}