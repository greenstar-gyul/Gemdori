package com.gemdori.review.service;

import java.util.List;
import com.gemdori.review.vo.ReviewVO;

public interface ReviewService {

    /**
     * 리뷰 등록
     * Service 구현체 내부에서 review 객체에 userCode가 설정되어 있는지 확인하거나,
     * 별도 파라미터로 userCode를 받아 설정할 수 있습니다.
     * @param review 등록할 리뷰 정보 (userCode, gameCode, reviewContents, rating 등 포함)
     * @return 리뷰 등록 성공 여부 (true: 성공, false: 실패)
     */
    boolean addReview(ReviewVO review);

    
    /** 특정 게임 리뷰 목록
     * 특정 게임의 리뷰 목록을 가져옵니다. (작성자 닉네임, 프로필 이미지 포함)
     * @param gameCode 조회할 게임의 코드
     * @return 해당 게임의 리뷰 목록 (List<ReviewVO>)
     */
    List<ReviewVO> getReviewsByGameCode(String gameCode);

    
    /**
     * 리뷰 삭제
     * Service 구현체 내부에서 reviewCode로 리뷰를 조회하여 작성자 userCode와
     * 파라미터로 받은 userCode를 비교하여 본인 확인 후 삭제를 진행합니다.
     * @param reviewCode 삭제할 리뷰의 코드
     * @param userCode 삭제를 요청한 사용자의 코드 (세션 등에서 가져온 값)
     * @return 리뷰 삭제 성공 여부 (true: 성공, false: 실패 또는 권한 없음)
     */
    boolean removeReview(String reviewCode, String userCode);

}