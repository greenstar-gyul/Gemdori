package com.gemdori.purchase.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gemdori.purchase.vo.GemdoriShoppingCartVO;

public interface GemdoriShoppingCartMapper {
    
    // 장바구니에 상품 추가
    int insertCartitem(GemdoriShoppingCartVO cartVO);
    
    // 사용자의 장바구니 목록 조회
    List<GemdoriShoppingCartVO> SelectCartItemsByUser(String userCode);
    
    // 장바구니 항목 삭제 (userCode, gameCode 기준)
    int deleteCartItemByUserAndGame(@Param("userCode") String userCode, @Param("gameCode") String gameCode);
    
    // 장바구니 비우기
    int clearCartByUser(String userCode);
    
    // 장바구니 항목 개수 조회
    int selectCartItemCountByUser(String userCode);
    
    // 장바구니 총 금액 조회
    int selectCartTotalAmount(String userCode);
    
    // 장바구니 할인 금액 조회
    int selectCartDiscountAmount(String userCode);
    
    // 특정 상품이 장바구니에 이미 존재하는지 확인
    int checkExistingCart(@Param("userCode") String userCode, @Param("gameCode") String gameCode);
}