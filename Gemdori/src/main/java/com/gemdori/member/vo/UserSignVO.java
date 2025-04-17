package com.gemdori.member.vo;

import java.util.Date;

import lombok.Data;

@Data
public class UserSignVO {
    private String userCode;
    private String userId;
    private String userPw;
    private int userStatus;
    private Date createTime;
    private Date deleteTime;
}
