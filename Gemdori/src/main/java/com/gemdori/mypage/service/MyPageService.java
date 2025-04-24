package com.gemdori.mypage.service;

import java.util.List;

import com.gemdori.mypage.vo.RecentReviewVO;
import com.gemdori.purchase.vo.PurchaseHistoryVO;

public interface MyPageService {
	// 유저의 최근 리뷰 3개 가져오기
	List<RecentReviewVO> getRecentReviews(String userCode);
	
	// 유저의 최근 구매 내역 가져오기
	List<PurchaseHistoryVO> getRecentPurchases(String userCode);
	
	// 유저의 모든 구매 내역 가져오기
	List<PurchaseHistoryVO> getAllPurchases(String userCode);
}