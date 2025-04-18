package com.gemdori.vo;

import java.util.Date;

import lombok.Data;

@Data
public class GemdoriShoppingCartVO {
	String cartCode;
	String userCode;
	String gameCode;
	Date cartDate;

	// 장바구니 화면에 표시할 게임 정보 필드 (조인 쿼리용)
    private String gameTitle;        // 게임 이름 (game_title에서 매핑)
    private String editionName;     // 게임 에디션 이름
    private Integer gamePrice;          // 게임 가격
    private Integer gameSalePrice;      // 할인된 가격
    private Integer discountPer;    // 할인율
    private String gameMainImage;
}
