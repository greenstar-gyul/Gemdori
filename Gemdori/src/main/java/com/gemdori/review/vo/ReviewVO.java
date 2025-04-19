package com.gemdori.review.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {
	private String reviewCode;// 오라클 데이터타입 수정해야 할듯?
	private String userCode;
	private String reviewContents;
	private double rating;
	private Date writeDate;
	private String gameCode;
	
	// 유저 프로필 이미지
	private String userImage;
	private String userNickname;
}