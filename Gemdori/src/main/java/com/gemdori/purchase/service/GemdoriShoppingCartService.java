package com.gemdori.purchase.service;

import java.util.List;

import com.gemdori.purchase.vo.GemdoriShoppingCartVO;

public interface GemdoriShoppingCartService {
    // 사용자의 장바구니 목록 조회
    List<GemdoriShoppingCartVO> getCartItemsByUser(String userCode);
    
    // 장바구니에 아이템 추가
    boolean addItemToCart(GemdoriShoppingCartVO item);
    
    // cartCode로 장바구니 아이템 삭제
    boolean removeCartItemByCartCode(String cartCode);
    
    // 장바구니 비우기
    boolean clearCart(String userCode);
    
    // 장바구니 아이템 개수 조회
    int getCartItemCount(String userCode);
    
    // 장바구니 총 금액
    int getCartTotalAmount(String userCode);

    // 장바구니 할인 총액
    int getCartDiscountAmount(String userCode);
    
    // 특정 상품이 장바구니에 이미 존재하는지 확인
    boolean checkExistingCart(String userCode, String gameCode);
}