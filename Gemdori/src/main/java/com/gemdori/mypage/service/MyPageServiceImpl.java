package com.gemdori.mypage.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.gemdori.common.DataSource;
import com.gemdori.mypage.mapper.MyPageMapper;
import com.gemdori.mypage.vo.RecentReviewVO;

public class MyPageServiceImpl implements MyPageService {
	SqlSession session = DataSource.getInstance().openSession(true);
	MyPageMapper mapper = session.getMapper(MyPageMapper.class);

	// 마이페이지 유저 최근 리뷰 3개 가져오기
	@Override
    public List<RecentReviewVO> getRecentReviews(String userCode) {
        return mapper.selectRecentReviews(userCode);
    }
}
