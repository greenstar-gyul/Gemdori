package com.gemdori.review.mapper;

import java.util.List;

import com.gemdori.review.vo.ReviewVO;

public interface ReviewMapper {
	
	// 특정 게임 리뷰목록 가져오기
	List<ReviewVO> selectReviewByGameCode(String gameCode);
	
	// 리뷰 등록 메서드
	int insertReview(ReviewVO reviewVO);
	
	
	/**
     * 리뷰 삭제 메서드
     * @param reviewCode 삭제할 리뷰의 고유 코드 (PK)
     * @return 삭제된 행의 수 (1이면 성공, 0이면 실패 또는 대상 없음)
     */
    int deleteReview(String reviewCode); // public은 인터페이스에서 생략 가능

    ReviewVO selectReviewByCode(String reviewCode);

}