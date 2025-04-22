package com.gemdori.mypage.service;

import java.util.List;

import com.gemdori.mypage.vo.RecentReviewVO;

public interface MyPageService {
	// 유저의 최근 리뷰 3개 가져오기
	List<RecentReviewVO> getRecentReviews(String userCode);
}
