package com.gemdori.review;

import java.io.IOException;

// ... (다른 import 문들은 나중에 추가)
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// Logger 사용을 위해 import 추가 (나중에)
// import org.slf4j.Logger;
// import org.slf4j.LoggerFactory;
import com.gemdori.common.Control;
import com.gemdori.main.service.GameService;
import com.gemdori.main.service.GameServiceImpl;
import com.gemdori.member.vo.UserFullVO;
import com.gemdori.member.vo.UserProfileVO;
import com.gemdori.review.service.ReviewService;
import com.gemdori.review.vo.ReviewVO;
import com.gemdori.service.impl.ReviewServiceImpl;

public class ReviewAddControl implements Control {

    // Logger 객체 선언 (나중에)
    // private static final Logger logger = LoggerFactory.getLogger(ReviewAddControl.class);

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
    	req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);

        UserFullVO loginUser = null; // 세션에서 가져올 사용자 정보를 담을 변수

        // 세션이 존재하고, 세션 안에 로그인 정보가 있는지 확인
        if (session != null) {
            // 세션에서 "loginUser"라는 이름으로 저장된 객체를 가져옵니다.
            // (주의!) "loginUser"는 실제 로그인 처리 시 session.setAttribute("loginUser", ...) 했던 이름과 동일해야 합니다.
            // 가져온 객체를 UserProfileVO 타입으로 형변환 합니다. (로그인 시 UserProfileVO 객체를 저장했다고 가정)
            Object sessionAttribute = session.getAttribute("loginUser");
            if (sessionAttribute instanceof UserFullVO) { // 타입 안정성을 위해 instanceof 확인 추가
                loginUser = (UserFullVO) sessionAttribute;
            }
            System.out.println("로그인 정보: " + loginUser);
        }

        // 로그인 정보가 없는 경우 (세션이 없거나, 세션에 loginUser 속성이 없거나, 타입이 맞지 않음)
        if (loginUser == null) {
            System.out.println("로그인되지 않은 사용자의 리뷰 작성 시도."); // 임시 로깅
            // 로그인 페이지로 리다이렉트(Redirect) 보냅니다.
            // (주의!) 로그인 페이지를 처리하는 실제 URL(컨트롤러 매핑 경로)로 수정해야 합니다.
            //       리다이렉트 시에는 ContextPath를 포함하는 것이 안전합니다.
            System.out.println("Redirecting to: loginForm.do"); // 임시 확인
            resp.sendRedirect("loginForm.do"); // 로그인 필요 메시지 전달 (선택 사항)
            return; // ★★★ 로그인 안됐으면 처리 중단 ★★★
        }

        String gameCode = req.getParameter("gameCode");
        String reviewContents = req.getParameter("reviewContents");
        String ratingStr = req.getParameter("rating");

        if (gameCode == null || reviewContents == null || ratingStr == null) {
        	System.out.println("필드 입력 누락");
            req.setAttribute("errorMsg", "모든 필드를 입력해주세요.");
            req.getRequestDispatcher("gameDetails.do?gameCode=" + gameCode).forward(req, resp);
            return;
        }

        double rating = Double.parseDouble(ratingStr);

        ReviewVO review = new ReviewVO();
        review.setGameCode(gameCode);
        review.setUserCode(loginUser.getUserCode());
        review.setReviewContents(reviewContents);
        review.setRating(rating);

        ReviewService rsvc = new ReviewServiceImpl();
        boolean success = rsvc.addReview(review);
        
        if (success) {
            // 7-1. 리뷰 등록 성공 시
            System.out.println("리뷰 등록 성공! 리다이렉트 준비: gameCode=" + gameCode); // 임시 확인
            // 게임 상세 페이지를 보여주는 URL로 리다이렉트 (Post-Redirect-Get 패턴)
            // (주의!) "gameDetails.do"는 게임 상세 페이지를 처리하는 컨트롤러의 URL 매핑 경로여야 합니다.
            GameService svc = new GameServiceImpl();
            if (svc.updateGameRating(gameCode)) {
            	System.out.println("평점 갱신 성공!");
            }
            else {
            	System.out.println("평점 갱신 실패");
            }
            String redirectUrl = "gameDetails.do?gameCode=" + gameCode; // <<-- 실제 게임 상세 URL 확인 필수!
            resp.sendRedirect(redirectUrl);
            // 리다이렉트 후에는 더 이상 다른 작업을 하지 않으므로 여기서 종료.
        } else {
            // 7-2. 리뷰 등록 실패 시 (서비스 로직에서 false를 반환한 경우)
            System.out.println("리뷰 등록 실패: gameCode=" + gameCode); // 임시 확인
            req.setAttribute("errorMsg", "리뷰 등록에 실패했습니다. 다시 시도해주세요."); // 실패 메시지 설정

            // 실패 시, 다시 입력 폼이 있는 게임 상세 페이지로 포워드
            // AJAX 방식이므로 게임 정보나 리뷰 목록을 다시 로드할 필요 없음
            String redirectUrl = "gameDetails.do?gameCode=" + gameCode; // <<-- 실제 게임 상세 URL 확인 필수!
            resp.sendRedirect(redirectUrl);
            // 포워드 후에는 더 이상 다른 작업을 하지 않으므로 여기서 종료.
        }
    }
}