package com.gemdori.mypage.mapper;

import java.util.List;

import com.gemdori.mypage.vo.RecentReviewVO;
import com.gemdori.purchase.vo.PurchaseHistoryVO;

public interface MyPageMapper {
	// 유저 최근 리뷰 3개 가져오기
	List<RecentReviewVO> selectRecentReviews(String userCode);
	
	// 유저 최근 구매 내역 가져오기
	List<PurchaseHistoryVO> selectRecentPurchases(String userCode);
	
	// 유저 모든 구매 내역 가져오기
	List<PurchaseHistoryVO> selectAllPurchases(String userCode);
}