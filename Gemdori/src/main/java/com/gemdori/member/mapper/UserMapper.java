package com.gemdori.member.mapper;

import java.util.Map;

import com.gemdori.member.vo.UserFullVO;
import com.gemdori.member.vo.UserProfileVO;
import com.gemdori.member.vo.UserSignVO;

public interface UserMapper {
	// 회원가입 - 유저 로그인 정보
	int insertUserSign(UserSignVO userSign);
	// 회원가입 - 유저 프로필 정보
	int insertUserProfile(UserProfileVO userProfile);
	// 회원가입 - 아이디 중복 확인
	int countByUserId(String userId);
	// 로그인
	UserFullVO selectUser(Map<String, String> param);
}
