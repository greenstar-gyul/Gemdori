package com.gemdori.mypage.mapper;

import java.util.List;

import com.gemdori.mypage.vo.RecentReviewVO;

public interface MyPageMapper {
	// 유저 최근 리뷰 3개 가져오기
	List<RecentReviewVO> selectRecentReviews(String userCode);
}
