package com.gemdori.review.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {
	private String reviewCode;//
	private String userCode;
	private String reviewContents;
	private double rating;
	private Date writeDate;
	private String gameCode;
	
	// 유저 프로필 이미지
	private String userImage;
	private String userName;
}