package com.gemdori.review;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.gemdori.common.Control;
import com.gemdori.main.service.GameService;
import com.gemdori.main.service.GameServiceImpl;
import com.gemdori.member.vo.UserFullVO;
import com.gemdori.review.service.ReviewService;
import com.gemdori.service.impl.ReviewServiceImpl;
import com.google.gson.Gson;

public class ReviewRemoveControl implements Control {

    private static final Logger logger = LoggerFactory.getLogger(ReviewRemoveControl.class);
    private Gson gson = new Gson(); // JSON 변환기

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	// 1. 요청 파라미터에서 reviewCode 가져오기
    	String reviewCode = req.getParameter("reviewCode");

    	// 2. 유효성 검사
    	if (reviewCode == null || reviewCode.isEmpty()) {
    	    logger.warn("리뷰 삭제 요청에 reviewCode 파라미터가 누락되었습니다.");
    	    // 리다이렉트로 실패 메시지 전달 (예: 쿼리 파라미터로)
    	    resp.sendRedirect("gameDetails.do?error=리뷰코드없음");
    	    return;
    	}

    	// 3. 로그인 검사
    	HttpSession session = req.getSession(false);
    	UserFullVO loginUser = null;
    	String userCode = null;

    	if (session != null) {
    	    Object sessionAttribute = session.getAttribute("loginUser");
    	    if (sessionAttribute instanceof UserFullVO) {
    	        loginUser = (UserFullVO) sessionAttribute;
    	        userCode = loginUser.getUserCode();
    	    }
    	}

    	if (loginUser == null) {
    	    logger.warn("로그인되지 않은 사용자의 리뷰 삭제 시도: reviewCode={}", reviewCode);
    	    resp.sendRedirect("login.do?redirect=gameDetails.do"); // 로그인 페이지로 리다이렉트
    	    return;
    	}

    	// 4. 리뷰 삭제 시도
    	ReviewService reviewService = new ReviewServiceImpl();
    	boolean success = false;

    	try {
    	    success = reviewService.removeReview(reviewCode, userCode);
    	    if (success) {
    	        logger.info("리뷰 삭제 성공: reviewCode={}, userCode={}", reviewCode, userCode);
    	    } else {
    	        logger.warn("리뷰 삭제 실패 또는 권한 없음: reviewCode={}, userCode={}", reviewCode, userCode);
    	    }
    	} catch (Exception e) {
    	    logger.error("리뷰 삭제 중 오류 발생", e);
    	}

    	// 5. 삭제 후 원래 게임 상세 페이지로 이동 (리뷰 목록 포함)
    	String gameCode = req.getParameter("gameCode"); // 함께 전달되었는지 확인 필요
    	if (gameCode == null || gameCode.isEmpty()) {
    	    // gameCode 없으면 메인으로
    	    resp.sendRedirect("main.do");
    	} else {
    		GameService svc = new GameServiceImpl();
    		svc.updateGameRating(gameCode);
    	    resp.sendRedirect("gameDetails.do?gameCode=" + gameCode);
    	}

    }
}