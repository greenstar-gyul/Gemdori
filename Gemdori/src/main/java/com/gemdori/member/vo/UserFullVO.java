package com.gemdori.member.vo;

import java.util.Date;

import lombok.Data;

@Data
public class UserFullVO {
	// 유저 로그인 정보
	private String userCode;
    private String userId;
    private String userPw;
    private Date createTime;
    
    // 유저 프로필 정보
    private String userFirstName;
    private String userLastName;
    private String userName;
    private String userEmail;
    private String userPhone;
    private Date userBirthday;
    private String userGender;
    private String userIntro;
    private String userImage;
    private Date updateTime; // from profile_tbl => 포르필 수정 일자

    // 유저 보안 정보 (security_tbl)
    private int loginFailCount;
    private Date lastLoginDate;
    private int isLocked;
    private Date securityUpdateTime; // 비밀번호 수정일자(프로필 수정일자와 DB명이 같아서 rename)
}
