package com.gemdori.member.mapper;

import java.util.Map;

import com.gemdori.member.vo.UserFullVO;
import com.gemdori.member.vo.UserProfileVO;
import com.gemdori.member.vo.UserSecurityVO;
import com.gemdori.member.vo.UserSignVO;

public interface UserMapper {
	// 회원가입 - 유저 로그인 정보
	int insertUserSign(UserSignVO userSign);
	// 회원가입 - 유저 프로필 정보
	int insertUserProfile(UserProfileVO userProfile);
	// 회원가입 - 아이디 중복 확인
	int countByUserId(String userId);
	// 회원가입 - 유저 초기 보안정보
	public int insertUserSecurity(UserSecurityVO userSign);
	// 로그인
	UserFullVO selectUser(Map<String, String> param);
	// 비밀번호 찾기 - 유저 아이디 존재 확인
	String findUserCodeByUserId(String userId);
	// 비밀번호 찾기 - userCode를 통한 이메일 정보 가져오기
	String findEmailByUserCode(String userCode);
	// 비밀번호 찾기 - 임시 비밀번호 업데이트
    int updateUserPassword(Map<String, String> param);
    // 유저 보안정보 조회
	UserSecurityVO selectUserSecurity(String userCode);
	// 유저 로그인 실패회수 조회
	Integer getLoginFailCount(String userCode);
	// 유저 로그인 실패 카운트 증가
	void increaseLoginFailCount(String userCode);
	// 로그인 성공 시 실패 카운트 초기화
	void resetLoginFailCount(String userCode);
	// 로그인 5회 실패 시 잠금
	void lockUserAccount(String userCode);
	// 로그인 성공 시 마지막 로그인 일자 업데이트
	public int updateLastLoginDate(String userCode);
	// 비밀번호 재발급 시 유저 보안 정보 변경
	int resetSecurityAfterPwUpdate(String userCode);
	// 회원 프로필 수정
	int updateUserProfile(UserProfileVO userProfile);
	// 회원 프로필 수정 후 유저 정보 session 다시 저장
	UserFullVO selectUserByUserCode(String userCode);
	// 기존 비밀번호 일치 여부 확인 (userCode, userPw)
    int checkPassword(Map<String, String> param);
    // 비밀번호 업데이트 (userCode, userPw)
    int newUserPassword(Map<String, String> param);
    // 보안정보의 비밀번호 수정일자 update_time 갱신
    int updateSecurityUpdateTime(String userCode);
}
