package com.gemdori.member.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.gemdori.common.DataSource;
import com.gemdori.member.mapper.UserMapper;
import com.gemdori.member.vo.UserFullVO;
import com.gemdori.member.vo.UserProfileVO;
import com.gemdori.member.vo.UserSecurityVO;
import com.gemdori.member.vo.UserSignVO;

public class UserServiceImpl implements UserService {

	SqlSession sqlSession = DataSource.getInstance().openSession(true);
	UserMapper mapper = sqlSession.getMapper(UserMapper.class);
	
	// 회원가입 - 유저 로그인 정보
	@Override
	public boolean addUserSign(UserSignVO userSign) {
		return mapper.insertUserSign(userSign) == 1;
	}
	// 회원가입 - 유저 프로필 정보
	@Override
	public boolean addUserProfile(UserProfileVO userProfile) {
		return mapper.insertUserProfile(userProfile) == 1;
	}
	// 회원가입 - 아이디 중복 확인
	@Override
	public boolean checkUserId(String userId) {
		return mapper.countByUserId(userId) == 0; // 0이면 사용 가능
	}
	// 회원가입 - 유저 초기 보안정보
	@Override
	public boolean addUserSecurity(UserSecurityVO userSecurity) {
	    return mapper.insertUserSecurity(userSecurity) == 1;
	}
	// 로그인 후 user 정보 session 저장
	@Override
	public UserFullVO selectUser(String userId, String userPw) {
		Map<String, String> param = new HashMap<>();
	    param.put("userId", userId);
	    param.put("userPw", userPw);
	    return mapper.selectUser(param);
	}
	// 비밀번호 찾기 - userId 존재 확인, 있을 경우 userCode 가져오기
    @Override
    public String findUserCodeByUserId(String userId) {
        return mapper.findUserCodeByUserId(userId);
    }
    // 비밀번호 찾기 - userCode를 통한 이메일 정보 가져오기
    @Override
    public String findEmailByUserCode(String userCode) {
        return mapper.findEmailByUserCode(userCode);
    }
    // 비밀번호 찾기 - userPw 가져오기
    @Override
    public boolean updateUserPassword(String userCode, String userPw) {

        Map<String, String> param = new HashMap<>();
        param.put("userCode", userCode);
        param.put("userPw", userPw);

        return mapper.updateUserPassword(param) == 1;
    }
    // 보안 정보 가져오기
    @Override
    public UserSecurityVO getUserSecurity(String userCode) {
        return mapper.selectUserSecurity(userCode);
    }
    // 로그인 실패 카운트 조회
    @Override
    public int getLoginFailCount(String userCode) {
    	Integer count = mapper.getLoginFailCount(userCode);
        return count != null ? count : 0;
    }
    // 로그인 실패 카운트 증가
    @Override
    public void increaseLoginFailCount(String userCode) {
        mapper.increaseLoginFailCount(userCode);
    }
    // 로그인 성공 시 실패 카운트 초기화
    @Override
    public void resetLoginFailCount(String userCode) {
        mapper.resetLoginFailCount(userCode);
    }
    // 로그인 실패 5회 시 계정 잠김
    @Override
    public void lockUserAccount(String userCode) {
        mapper.lockUserAccount(userCode);
    }
    // 마지막 로그인 정보 저장
    @Override
    public boolean updateLastLoginDate(String userCode) {
        return mapper.updateLastLoginDate(userCode) == 1;
    }
    // 비밀번호 재발급 시 유저 보안 정보 변경
    @Override
    public boolean resetSecurityAfterPwUpdate(String userCode) {
        return mapper.resetSecurityAfterPwUpdate(userCode) == 1;
    }
    // 회원정보 수정
    @Override
    public boolean updateUserProfile(UserProfileVO userProfile) {
        return mapper.updateUserProfile(userProfile) == 1;
    }
    // 회원정보 수정 후 session 다시 저장
    @Override
    public UserFullVO selectUserByUserCode(String userCode) {
        return mapper.selectUserByUserCode(userCode);
    }
    // 비밀번호 변경 기능
    @Override
    public boolean changePassword(String userCode, String currentPw, String newPw) {
        // 1. 현재 비밀번호 일치 여부 확인
        Map<String, String> param = new HashMap<>();
        param.put("userCode", userCode);
        param.put("userPw", currentPw);

        int check = mapper.checkPassword(param);
        if (check == 0) {
            return false; // 기존 비밀번호가 일치하지 않음
        }

        // 2. 새 비밀번호로 변경
        param.put("userPw", newPw); // 같은 param 재사용 (key 중복으로 덮어쓰기)
        int update = mapper.newUserPassword(param);

        // 3. 보안정보 수정일자 갱신
        if (update == 1) {
            mapper.updateSecurityUpdateTime(userCode);
            return true;
        }

        return false;
    }
}
