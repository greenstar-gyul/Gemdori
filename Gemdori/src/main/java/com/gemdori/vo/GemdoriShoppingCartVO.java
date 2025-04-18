package com.gemdori.vo;

import java.util.Date;

import lombok.Data;

@Data
public class GemdoriShoppingCartVO {
	String cartCode;
	String userCode;
	String gameCode;
	Date cartDate;
	
	// 게임 정보 (별도 VO 분리?)
    String gameTitle;
    Integer gamePrice;
    Integer gameSalePrice;
    String gameMainImage;
    // 필요에 따라 다른 필드 추가
}
