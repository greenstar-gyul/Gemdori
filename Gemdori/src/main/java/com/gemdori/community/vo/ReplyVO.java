package com.gemdori.community.vo;

import java.util.Date;

public class ReplyVO {
    private int replyId;        // 댓글 ID
    private String topicCode;   // 주제 코드
    private String content;     // 댓글 내용
    private String writer;      // 작성자
    private Date writeDate;     // 작성 날짜

    // Getter 및 Setter 메서드
    public int getReplyId() {
        return replyId;
    }

    public void setReplyId(int replyId) {
        this.replyId = replyId;
    }

    public String getTopicCode() {
        return topicCode;
    }

    public void setTopicCode(String topicCode) {
        this.topicCode = topicCode;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public Date getWriteDate() {
        return writeDate;
    }

    public void setWriteDate(Date writeDate) {
        this.writeDate = writeDate;
    }
}
