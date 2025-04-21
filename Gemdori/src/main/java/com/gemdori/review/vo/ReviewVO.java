package com.gemdori.review.vo;


import lombok.Data;

@Data
public class ReviewVO {
    private String gameCode;
    private String userCode;
    private Double rating;
    private String reviewContents;
}