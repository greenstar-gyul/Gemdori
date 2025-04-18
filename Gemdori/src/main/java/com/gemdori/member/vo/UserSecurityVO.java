package com.gemdori.member.vo;

import java.util.Date;

import lombok.Data;

@Data
public class UserSecurityVO {
	private String userCode;
	private int loginFailCount;
	private Date lastLoginDate;
	private int isLocked;
	private Date updateTime;
}
