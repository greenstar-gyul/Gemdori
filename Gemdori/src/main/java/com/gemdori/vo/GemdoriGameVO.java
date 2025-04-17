package com.gemdori.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class GemdoriGameVO {
	String gameCode;
	String gameTitle;
	String contents;
	String gamePublisher;
	Date publishingDate;
	int gamePrice;
	String gameGenre;
	String gameCategory;
	String gameTag;
	String gameMainImage;
	String gameSysReq; // 게임사양, json
}
