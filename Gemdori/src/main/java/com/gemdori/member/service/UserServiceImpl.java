package com.gemdori.member.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.gemdori.common.DataSource;
import com.gemdori.member.mapper.UserMapper;
import com.gemdori.member.vo.UserFullVO;
import com.gemdori.member.vo.UserProfileVO;
import com.gemdori.member.vo.UserSignVO;

public class UserServiceImpl implements UserService {

	SqlSession sqlSession = DataSource.getInstance().openSession(true);
	UserMapper mapper = sqlSession.getMapper(UserMapper.class);
	
	@Override
	public boolean addUserSign(UserSignVO userSign) {
		
		return mapper.insertUserSign(userSign) == 1;
	}

	@Override
	public boolean addUserProfile(UserProfileVO userProfile) {
		
		return mapper.insertUserProfile(userProfile) == 1;
	}

	@Override
	public boolean checkUserId(String userId) {
		
		return mapper.countByUserId(userId) == 0; // 0이면 사용 가능
	}

	@Override
	public UserFullVO selectUser(String userId, String userPw) {
		Map<String, String> param = new HashMap<>();
	    param.put("userId", userId);
	    param.put("userPw", userPw);
	    return mapper.selectUser(param);
	}

}
