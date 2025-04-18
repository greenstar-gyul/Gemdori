package com.gemdori.purchase.mapper;

import java.util.List;

import com.gemdori.purchase.vo.GemdoriShoppingCartVO;

public interface GemdoriShoppingCartMapper {
	// 사용자 별 장바구니 목록 전체 조회
	// 사용자 별 장바구니 목록 전체 조회
	List<GemdoriShoppingCartVO> SelectCartItemsByUser(String userCode);

	// 장바구니에 아이템 추가 (성공시 1 반환)
	int insertCartitem(GemdoriShoppingCartVO cartItem);

	// 장바구니에 아이템 삭제 (성공시 1 반환)
	int deleteCartItemByUserAndGame(String userCode, String gameCode);

	// 장바구니 담긴 총량 조회
	int selectCartItemCountByUser(String userCode);
	
	// 장바구니 할인 총액 계산
	int selectCartDiscountAmount(String userCode);

	// 사용자 장바구니 비우기
	int clearCartByUser(String userCode);

	int selectCartTotalAmount(String userCode);
	// 추가가능 -> 장바구니 내 검색
	//GemdoriShoppingCartVO selectCartItemByUserAndGame(String userCode, String gameCode);
}