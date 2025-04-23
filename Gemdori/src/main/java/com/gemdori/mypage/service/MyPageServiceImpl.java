package com.gemdori.mypage.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.gemdori.common.DataSource;
import com.gemdori.mypage.mapper.MyPageMapper;
import com.gemdori.mypage.vo.RecentReviewVO;
import com.gemdori.purchase.vo.PurchaseHistoryVO;

public class MyPageServiceImpl implements MyPageService {
	SqlSession session = DataSource.getInstance().openSession(true);
	MyPageMapper mapper = session.getMapper(MyPageMapper.class);

	// 마이페이지 유저 최근 리뷰 3개 가져오기
	@Override
    public List<RecentReviewVO> getRecentReviews(String userCode) {
        return mapper.selectRecentReviews(userCode);
    }

	// 마이페이지 유저 최근 구매 내역 가져오기
	// com.gemdori.mypage.service.MyPageServiceImpl.java
	@Override
	public List<PurchaseHistoryVO> getRecentPurchases(String userCode) {
	    // ======> 로그 추가: MyBatis 매퍼 호출 직후! <======
	    List<PurchaseHistoryVO> purchases = mapper.selectRecentPurchases(userCode); // 실제 DB 조회 실행

	    if (purchases != null) {
	        // 이 로그가 콘솔에 어떻게 찍히는지 반드시 확인하세요!
	        System.out.println("### MyPageServiceImpl: mapper.selectRecentPurchases returned list size = " + purchases.size() + " for user " + userCode);
	    } else {
	        System.out.println("### MyPageServiceImpl: mapper.selectRecentPurchases returned null for user " + userCode);
	    }
	    // ====================================================

	    return purchases; // 매퍼가 반환한 리스트를 그대로 반환
	}

	// 마이페이지 유저 모든 구매 내역 가져오기
	@Override
	public List<PurchaseHistoryVO> getAllPurchases(String userCode) {
		return mapper.selectAllPurchases(userCode);
	}
}