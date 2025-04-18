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
    
    // 유저 보안 정보
	private int loginFailCount;
	private Date lastLoginDate;
	private int isLocked;
	private Date updateTime;
}
