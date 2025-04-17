package com.gemdori.member.vo;

import java.util.Date;

import lombok.Data;

@Data
public class UserProfileVO {
    private String userCode;
    private String userFirstName;
    private String userLastName;
    private String userName;
    private String userEmail;
    private String userPhone;
    private Date userBirthday;
    private String userGender;
    private String userIntro;
    private String userImage;
    private Date updateTime;
}
