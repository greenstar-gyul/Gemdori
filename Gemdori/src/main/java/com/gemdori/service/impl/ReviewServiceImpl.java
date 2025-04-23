package com.gemdori.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger; // 로깅을 위한 Logger 추가
import org.slf4j.LoggerFactory; // 로깅

import com.gemdori.common.DataSource;
import com.gemdori.review.mapper.ReviewMapper;
import com.gemdori.review.service.ReviewService;
import com.gemdori.review.vo.ReviewVO;

public class ReviewServiceImpl implements ReviewService {

    // Logger 추가
    private static final Logger logger = LoggerFactory.getLogger(ReviewServiceImpl.class);

    // getReviewsByGameCode 메소드 구현
    @Override
    public List<ReviewVO> getReviewsByGameCode(String gameCode) {
        // SqlSession을 메소드 내에서 열고 try-with-resources 사용 (자동 close 보장)
        try (SqlSession session = DataSource.getInstance().openSession()) {
            ReviewMapper mapper = session.getMapper(ReviewMapper.class);
            return mapper.selectReviewByGameCode(gameCode); // Mapper 메소드 이름 확인! (selectReviewByGameCode 였음)
        } catch (Exception e) {
            logger.error("게임 코드별 리뷰 조회 중 오류 발생: gameCode={}", gameCode, e);
            // 예외를 다시 던지거나, 빈 리스트 또는 null 반환 등 정책 결정 필요
            // 여기서는 간단히 null 반환 예시 (상황에 맞게 수정)
            return null;
        }
    }

    @Override
    public boolean addReview(ReviewVO review) {
        // SqlSession을 메소드 내에서 열고 수동 커밋 모드 사용
        SqlSession session = null; // try 블록 밖에서도 참조 가능하도록 선언
        boolean success = false;
        try {
            session = DataSource.getInstance().openSession(false); // 수동 커밋: false
            ReviewMapper mapper = session.getMapper(ReviewMapper.class);
            int result = mapper.insertReview(review);
            if (result == 1) {
                session.commit(); // 성공 시 커밋
                success = true;
                logger.info("리뷰 등록 성공: reviewCode={}", review.getReviewCode()); // 등록된 코드 확인 (시퀀스 등으로 생성 후 반환되도록 Mapper 수정 필요 가능성)
            } else {
                session.rollback(); // 결과가 1이 아니면 롤백 (사실 INSERT 실패 시 예외 발생 가능성이 높음)
                logger.warn("리뷰 등록 실패 (영향받은 행 없음): {}", review);
            }
        } catch (Exception e) {
            if (session != null) {
                session.rollback(); // 예외 발생 시 롤백
            }
            logger.error("리뷰 등록 중 오류 발생: {}", review, e);
            success = false; // 실패 처리
        } finally {
            if (session != null) {
                session.close(); // 세션 닫기 (필수!)
            }
        }
        return success;
    }

    // removeReview 메소드 구현
    @Override
    public boolean removeReview(String reviewCode, String userCode) {
        SqlSession session = null;
        boolean success = false;
        try {
            session = DataSource.getInstance().openSession(false); // 수동 커밋
            ReviewMapper mapper = session.getMapper(ReviewMapper.class);

            // 1. 권한 검증을 위해 삭제할 리뷰 정보를 먼저 조회
            // (Mapper에 selectReviewByCode 메소드가 필요할 수 있음. 여기서는 임시로 만든다고 가정)
            ReviewVO review = mapper.selectReviewByCode(reviewCode); // <<-- 이 메소드가 Mapper에 필요!

            if (review == null) {
                logger.warn("삭제할 리뷰를 찾을 수 없음: reviewCode={}", reviewCode);
                // 롤백은 필요 없지만, 세션은 닫아야 함 (finally에서 처리)
                return false; // 리뷰 없음 = 삭제 실패
            }

            // 2. 작성자 본인 확인 (권한 검증)
            if (review.getUserCode() != null && review.getUserCode().equals(userCode)) {
                // 3. 본인 확인 완료 시 삭제 진행
                int result = mapper.deleteReview(reviewCode);
                if (result == 1) {
                    session.commit(); // 삭제 성공 시 커밋
                    success = true;
                    logger.info("리뷰 삭제 성공: reviewCode={}", reviewCode);
                } else {
                    session.rollback(); // 삭제 실패 (영향받은 행 없음)
                    logger.warn("리뷰 삭제 실패 (영향받은 행 없음): reviewCode={}", reviewCode);
                }
            } else {
                // 본인 아님 (권한 없음)
                session.rollback(); // 롤백 (DB 변경 작업은 없었지만 명시적)
                logger.warn("리뷰 삭제 권한 없음: reviewCode={}, 요청자 userCode={}", reviewCode, userCode);
                success = false;
            }

        } catch (Exception e) {
            if (session != null) {
                session.rollback(); // 예외 발생 시 롤백
            }
            logger.error("리뷰 삭제 중 오류 발생: reviewCode={}", reviewCode, e);
            success = false;
        } finally {
            if (session != null) {
                session.close(); // 세션 닫기 (필수!)
            }
        }
        return success;
    }

}