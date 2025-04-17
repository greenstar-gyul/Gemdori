package com.gemdori.vo;

import java.util.Date;

import lombok.Data;

@Data
public class GemdoriGameVO {
	private String gameCode;
	private String gameTitle;
	private String gameDesc;
	private String gameContents;
	private String gameDeveloper;
	private String gamePublisher;
	private Date publishingDate;
	private int gamePrice;
	private int gameSalePrice;
	private int discountPer;
	private String languageSup;
	private int requiredAge;
	private String legalNotice;
	private int freeGame;
	private String website;
	private String gameGenre;
	private String gameCategory;
	private String gameTag;
	private String gameMainImage;
	private String descImages;
	private String gameSysReq;
	private String gameSysReqR;
	private int dlcGame;
	
	private Double avgRating;
	
	private String parentGame;
}