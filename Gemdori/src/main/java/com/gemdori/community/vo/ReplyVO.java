package com.gemdori.community.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
    private int commentCode;        // 댓글 ID
    private String topicCode;   // 주제 코드
    private Date writeDate;     // 작성 날짜
    private String commentContents; // 댓글 내용
    private String userCode; // 작성자 코드
    private String parentCommentCode; // 대댓글의 부모댓글
}
