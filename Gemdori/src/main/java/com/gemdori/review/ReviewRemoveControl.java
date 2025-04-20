package com.gemdori.review;

import java.io.IOException;
import java.util.HashMap; // Java 8 이하 호환 위해 Map.of 대신 사용
import java.util.Map;    // Java 8 이하 호환 위해 Map.of 대신 사용

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.gemdori.common.Control;
import com.gemdori.member.vo.UserProfileVO; // UserProfileVO 경로 확인
import com.gemdori.review.service.ReviewService;
import com.gemdori.service.impl.ReviewServiceImpl;
import com.google.gson.Gson;

public class ReviewRemoveControl implements Control {

    private static final Logger logger = LoggerFactory.getLogger(ReviewRemoveControl.class);
    private Gson gson = new Gson(); // JSON 변환기

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 응답 타입을 JSON으로 설정
        resp.setContentType("application/json; charset=utf-8");

        // 1. 요청 파라미터에서 reviewCode 가져오기 (POST 방식으로 온다고 가정)
        String reviewCode = req.getParameter("reviewCode");

        // 2. reviewCode 유효성 검사
        if (reviewCode == null || reviewCode.isEmpty()) {
            logger.warn("리뷰 삭제 요청에 reviewCode 파라미터가 누락되었습니다.");
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, Object> errorResult = new HashMap<>();
            errorResult.put("success", false);
            errorResult.put("message", "삭제할 리뷰 코드가 필요합니다.");
            resp.getWriter().write(gson.toJson(errorResult));
            return;
        }

        // 3. 로그인 상태 확인 및 userCode 가져오기
        HttpSession session = req.getSession(false);
        UserProfileVO loginUser = null;
        String userCode = null;

        if (session != null) {
            Object sessionAttribute = session.getAttribute("loginUser");
            if (sessionAttribute instanceof UserProfileVO) {
                loginUser = (UserProfileVO) sessionAttribute;
                userCode = loginUser.getUserCode();
            }
        }

        if (userCode == null) {
            logger.warn("로그인되지 않은 사용자의 리뷰 삭제 시도: reviewCode={}", reviewCode);
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 Unauthorized
            Map<String, Object> errorResult = new HashMap<>();
            errorResult.put("success", false);
            errorResult.put("message", "리뷰를 삭제하려면 로그인이 필요합니다.");
            resp.getWriter().write(gson.toJson(errorResult));
            return;
        }

        // 4. ReviewService 호출하여 삭제 시도
        ReviewService reviewService = new ReviewServiceImpl(); // (개선 필요: 싱글톤 등)
        boolean success = false;
        String message = "";
        Map<String, Object> result = new HashMap<>();

        try {
            success = reviewService.removeReview(reviewCode, userCode);
            if (success) {
                logger.info("리뷰 삭제 성공: reviewCode={}, userCode={}", reviewCode, userCode);
                message = "리뷰가 성공적으로 삭제되었습니다.";
            } else {
                // removeReview 내부에서 권한 없거나 리뷰가 없는 경우 false 반환
                logger.warn("리뷰 삭제 실패 또는 권한 없음: reviewCode={}, userCode={}", reviewCode, userCode);
                message = "리뷰를 삭제할 수 없거나 권한이 없습니다.";
                // 실패 시에는 별도 상태 코드 없이 200 OK에 실패 메시지 전달
            }
            result.put("success", success);
            result.put("message", message);

        } catch (Exception e) {
            logger.error("리뷰 삭제 중 오류 발생: reviewCode={}, userCode={}", reviewCode, userCode, e);
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Internal Server Error
            result.put("success", false);
            result.put("message", "리뷰 삭제 중 오류가 발생했습니다.");
            resp.getWriter().write(gson.toJson(result));
            return;
        }

        // 5. 결과 JSON 응답 전송
        resp.getWriter().write(gson.toJson(result));
    }
}