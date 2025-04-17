package com.gemdori.member.service;

import com.gemdori.member.vo.UserFullVO;
import com.gemdori.member.vo.UserProfileVO;
import com.gemdori.member.vo.UserSignVO;

public interface UserService {
	// 회원가입 로그인 정보
	boolean addUserSign(UserSignVO userSign);
	// 회원가입 프로필 정보
	boolean addUserProfile(UserProfileVO userProfile);
	// 회원가입 아이디 중복확인
	boolean checkUserId(String userId);
	
	// 로그인
	UserFullVO selectUser(String userId, String userPw);
}
