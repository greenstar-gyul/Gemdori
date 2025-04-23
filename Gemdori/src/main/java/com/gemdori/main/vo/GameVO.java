package com.gemdori.main.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class GameVO {
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

    // 평점 컬럼 (7번 기능에서 사용)
    private Double gameRating;

    // DLC 게임일 경우, 원본 게임 코드 (원본 게임은 NULL)
    private String parentGame;
    
    // 인게임 이미지 리스트
    private List<String> imageList;

    private int reviewCount; // 리뷰 개수
} 