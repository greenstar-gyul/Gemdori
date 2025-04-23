package com.gemdori.member.service;

import com.gemdori.member.vo.UserFullVO;
import com.gemdori.member.vo.UserProfileVO;
import com.gemdori.member.vo.UserSecurityVO;
import com.gemdori.member.vo.UserSignVO;

public interface UserService {
	// 회원가입 로그인 정보
	boolean addUserSign(UserSignVO userSign);
	// 회원가입 프로필 정보
	boolean addUserProfile(UserProfileVO userProfile);
	// 회원가입 초기 보안정보
	boolean addUserSecurity(UserSecurityVO userSecurity);
	// 회원가입 아이디 중복확인
	boolean checkUserId(String userId);
	// 로그인
	UserFullVO selectUser(String userId, String userPw);
	// 비밀번호 찾기 시 userId 존재 확인 후 userCode 가져오기
	String findUserCodeByUserId(String userId);
	// 가져온 userCode를 통해 userEmail 가져오기
    String findEmailByUserCode(String userCode);
    // 임시 비밀번호 업데이트
    boolean updateUserPassword(String userCode, String userPw);
    // 유저 보안정보 조회
    UserSecurityVO getUserSecurity(String userCode);
    // 유저 로그인 실패 조회
    int getLoginFailCount(String userCode);
    // 유저 로그인 실패 카운트 증가
    void increaseLoginFailCount(String userCode);
    // 로그인 성공 시 실패 카운트 초기화
    void resetLoginFailCount(String userCode);
    // 로그인 실패 5회 시 계정 잠김
    void lockUserAccount(String userCode);
    // 마지막 로그인 시간 저장
    boolean updateLastLoginDate(String userCode);
    // 비밀번호 재발급 시 유저 보안 정보 변경
    boolean resetSecurityAfterPwUpdate(String userCode);
    // 회원 프로필 수정
    boolean updateUserProfile(UserProfileVO userProfile);
    // 회원 정보 수정 후 재확인
    UserFullVO selectUserByUserCode(String userCode);
    // 비밀번호 체크
    boolean checkPassword(String userCode, String userPw);
    // 비밀번호 변경
    boolean changePassword(String userCode, String currentPw, String newPw);
    // 회원탈퇴
    boolean deleteUser(String userCode);
}
