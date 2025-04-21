package com.gemdori.review;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.gemdori.common.Control;
import com.gemdori.review.service.ReviewService;
import com.gemdori.review.vo.ReviewVO;
import com.gemdori.service.impl.ReviewServiceImpl;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class ReviewListControl implements Control{

	private static final Logger logger = LoggerFactory.getLogger(ReviewListControl.class);
    // Gson 객체는 스레드에 안전(thread-safe)하므로 멤버 변수로 두거나 static으로 만들어 재사용 가능
    private Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create(); // 날짜 포맷 지정

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 응답 타입을 JSON으로 설정하고, 문자 인코딩은 UTF-8로 지정
        resp.setContentType("application/json; charset=utf-8");

        // 1. 요청 파라미터에서 gameCode 가져오기
        String gameCode = req.getParameter("gameCode");

        // 2. gameCode 유효성 검사
        if (gameCode == null || gameCode.isEmpty()) {
            logger.warn("리뷰 목록 조회 요청에 gameCode 파라미터가 누락되었습니다.");
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400 Bad Request 상태 코드 설정
            // 오류 메시지도 JSON 형태로 반환하는 것이 좋음
            resp.getWriter().write("{\"success\": false, \"message\": \"게임 코드가 필요합니다.\"}");
            return;
        }

        List<ReviewVO> reviewList = new ArrayList<>(); // 기본값으로 빈 리스트 설정
        try {
            // 3. ReviewService를 통해 리뷰 목록 조회
            ReviewService reviewService = new ReviewServiceImpl(); // (개선 필요 지점: 싱글톤 등 고려)
            reviewList = reviewService.getReviewsByGameCode(gameCode);

            // 4. 조회된 리뷰 목록을 JSON 문자열로 변환
            String json = gson.toJson(reviewList);
            logger.debug("게임 코드 '{}'의 리뷰 목록 JSON: {}", gameCode, json); // 디버그 레벨 로그

            // 5. JSON 문자열을 응답으로 클라이언트에게 전송
            resp.getWriter().write(json);

        } catch (Exception e) {
            logger.error("리뷰 목록 조회 중 오류 발생: gameCode={}", gameCode, e);
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Internal Server Error 상태 코드 설정
            resp.getWriter().write("{\"success\": false, \"message\": \"리뷰 목록을 불러오는 중 오류가 발생했습니다.\"}");
        }
    }
}
