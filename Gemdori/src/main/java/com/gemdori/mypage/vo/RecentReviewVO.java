package com.gemdori.mypage.vo;

import lombok.Data;

@Data
public class RecentReviewVO {
    private String gameTitle;
    private String reviewContents;
    private String writeDate;
    private int rating;
}
