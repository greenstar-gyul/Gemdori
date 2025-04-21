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
        
        // resp.sendRedirect("gameDetails.do?gameCode=" + gameCode);
        
    	/*
        req.setCharacterEncoding("utf-8");

        String gameCode = req.getParameter("gameCode");
        String ratingStr = req.getParameter("rating");
        String reviewContents = req.getParameter("reviewContents");

        // --- 3. 별점(rating) 값 유효성 검사 및 타입 변환 ---
        double rating = 0.0;

        // 3-1. 값이 비어있는지 확인
        if (ratingStr == null || ratingStr.isEmpty()) {
            System.out.println("별점 파라미터 누락: gameCode=" + gameCode); // 임시 로깅
            req.setAttribute("errorMsg", "별점을 선택해주세요."); // 오류 메시지 저장

            // ★★★ 오류 메시지만 담아서 원래 페이지 Tiles 정의로 forward ★★★
            // 게임 정보나 리뷰 목록을 다시 조회할 필요 없음!
            // req.getRequestDispatcher("gameDetails.do?gameCode=" + gameCode).forward(req, resp);
            resp.sendRedirect("gameDetails.do?gameCode=" + gameCode);
            return;
        }

        // 3-2. 문자열 값을 double 타입으로 변환 시도
        try {
            rating = Double.parseDouble(ratingStr);

            // 3-3. 변환된 값이 유효한 범위인지 확인
            if (rating < 0.5 || rating > 5.0) {
                System.out.println("잘못된 별점 값 범위: rating=" + ratingStr + ", gameCode=" + gameCode); // 임시 로깅
                req.setAttribute("errorMsg", "별점은 0.5점에서 5.0점 사이로 선택해주세요.");

                // ★★★ 오류 메시지만 담아서 원래 페이지 Tiles 정의로 forward ★★★
                req.getRequestDispatcher("main/gameDetails.tiles").forward(req, resp);
                return;
            }

        } catch (NumberFormatException e) {
            // 3-4. 숫자로 변환할 수 없는 값이 들어온 경우
            System.err.println("별점 파라미터 숫자 변환 오류: rating=" + ratingStr + ", gameCode=" + gameCode + ", Error: " + e.getMessage()); // 임시 오류 로깅
            req.setAttribute("errorMsg", "별점 값이 올바르지 않습니다.");

            // ★★★ 오류 메시지만 담아서 원래 페이지 Tiles 정의로 forward ★★★
            req.getRequestDispatcher("main/gameDetails.tiles").forward(req, resp);
            return;
        }

        // --- 유효성 검사 통과 ---
        System.out.println("Validated rating: " + rating); // 임시 확인
        

        // --- 4. 로그인 상태 확인 및 사용자 정보 가져오기 ---

        // 4-1. 현재 요청과 연결된 세션을 가져옵니다. (세션이 없으면 null 반환)
        //      true를 주면 세션이 없을 때 새로 만들지만, 로그인 확인 시에는 기존 세션을 확인해야 하므로 false를 사용합니다.
        HttpSession session = req.getSession(false);

        UserProfileVO loginUser = null; // 세션에서 가져올 사용자 정보를 담을 변수

        // 4-2. 세션이 존재하고, 세션 안에 로그인 정보가 있는지 확인
        if (session != null) {
            // 세션에서 "loginUser"라는 이름으로 저장된 객체를 가져옵니다.
            // (주의!) "loginUser"는 실제 로그인 처리 시 session.setAttribute("loginUser", ...) 했던 이름과 동일해야 합니다.
            // 가져온 객체를 UserProfileVO 타입으로 형변환 합니다. (로그인 시 UserProfileVO 객체를 저장했다고 가정)
            Object sessionAttribute = session.getAttribute("loginUser");
            if (sessionAttribute instanceof UserProfileVO) { // 타입 안정성을 위해 instanceof 확인 추가
                loginUser = (UserProfileVO) sessionAttribute;
            }
        }

        // 4-3. 로그인 정보가 없는 경우 (세션이 없거나, 세션에 loginUser 속성이 없거나, 타입이 맞지 않음)
        if (loginUser == null) {
            System.out.println("로그인되지 않은 사용자의 리뷰 작성 시도."); // 임시 로깅
            // 로그인 페이지로 리다이렉트(Redirect) 보냅니다.
            // (주의!) 로그인 페이지를 처리하는 실제 URL(컨트롤러 매핑 경로)로 수정해야 합니다.
            //       리다이렉트 시에는 ContextPath를 포함하는 것이 안전합니다.
            String loginUrl = req.getContextPath() + "/loginForm.do"; // <<-- 실제 로그인 폼 URL로 수정 필수!
            System.out.println("Redirecting to: " + loginUrl); // 임시 확인
            resp.sendRedirect(loginUrl + "?msg=loginRequired"); // 로그인 필요 메시지 전달 (선택 사항)
            return; // ★★★ 로그인 안됐으면 처리 중단 ★★★
        }

        // --- 로그인 확인 완료 ---
        // 이제 'loginUser' 변수에는 로그인한 사용자의 정보(UserProfileVO)가 들어있습니다.
        // 사용자의 고유 코드(userCode)를 얻어옵니다. (UserProfileVO에 getUserCode() 메소드가 있다고 가정)
        String userCode = loginUser.getUserCode();
        System.out.println("Logged in userCode: " + userCode); // 임시 확인

        
        // --- 5. ReviewVO 객체 생성 및 값 설정 ---

        // 5-1. ReviewVO 객체를 새로 생성합니다.
        ReviewVO reviewVO = new ReviewVO();

        // 5-2. VO 객체의 각 필드(변수)에 해당 값들을 설정(저장)합니다.
        //      VO의 setter 메소드 (예: setGameCode())를 사용합니다.
        reviewVO.setGameCode(gameCode);        // 게임 코드 설정
        reviewVO.setUserCode(userCode);        // 로그인한 사용자의 코드 설정 (매우 중요!)
        reviewVO.setRating(rating);            // 유효성 검사를 통과한 별점(double 타입) 설정
        reviewVO.setReviewContents(reviewContents); // 사용자가 입력한 리뷰 내용 설정

        // (참고) ReviewVO의 다른 필드들 (reviewCode, writeDate, userName, userImage)은
        // 여기서 설정하지 않습니다.
        // - reviewCode: DB에서 INSERT 시 시퀀스로 자동 생성될 것임
        // - writeDate: DB에서 INSERT 시 SYSDATE로 자동 설정될 것임
        // - userName, userImage: 리뷰 목록 조회 시 JOIN으로 가져올 정보임

        // --- 임시 확인용 출력 (나중에 삭제하거나 Logger로 변경) ---
        // VO 객체에 값이 잘 담겼는지 확인합니다. (ReviewVO에 toString()이 구현되어 있다면 편리)
        System.out.println("ReviewVO created: " + reviewVO.toString()); // Lombok @Data 사용 시 toString() 자동 생성됨

     // --- 6. 서비스 호출 및 결과 확인 ---

        // 6-1. ReviewService 구현체 객체를 가져옵니다.
        //      (주의!) 직접 new로 생성하는 것은 개선이 필요합니다. (나중에 싱글톤 등으로)
        //      지금은 일단 이대로 진행합니다.
        ReviewService reviewService = new ReviewServiceImpl();

        // 6-2. 서비스의 addReview 메소드를 호출하고, 파라미터로 reviewVO 객체를 전달합니다.
        //      addReview 메소드는 DB 저장 성공 시 true, 실패 시 false를 반환하도록 구현했습니다.
        boolean success = false; // 결과 저장 변수 초기화
        try {
            success = reviewService.addReview(reviewVO);
        } catch (Exception e) {
            // 서비스 계층이나 그 하위(Mapper, DB)에서 예측하지 못한 오류가 발생했을 경우를 대비
            System.err.println("리뷰 등록 서비스 실행 중 예외 발생: " + e.getMessage()); // 임시 오류 로깅 (Logger 사용 권장)
            // 예외 발생 시에도 실패로 간주
            success = false;
            // (선택) 조금 더 상세한 오류 페이지로 이동하거나, 사용자에게 일반적인 오류 메시지를 보여줄 수 있습니다.
             req.setAttribute("errorMsg", "리뷰 등록 중 시스템 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
             req.getRequestDispatcher("main/gameDetails.tiles").forward(req, resp);
             return;
        }


     // --- 7. 결과에 따른 분기 처리 (리다이렉트 또는 포워드) ---

        if (success) {
            // 7-1. 리뷰 등록 성공 시
            System.out.println("리뷰 등록 성공! 리다이렉트 준비: gameCode=" + gameCode); // 임시 확인
            // 게임 상세 페이지를 보여주는 URL로 리다이렉트 (Post-Redirect-Get 패턴)
            // (주의!) "gameDetails.do"는 게임 상세 페이지를 처리하는 컨트롤러의 URL 매핑 경로여야 합니다.
            String redirectUrl = req.getContextPath() + "/gameDetails.do?gameCode=" + gameCode; // <<-- 실제 게임 상세 URL 확인 필수!
            resp.sendRedirect(redirectUrl);
            // 리다이렉트 후에는 더 이상 다른 작업을 하지 않으므로 여기서 종료.
        } else {
            // 7-2. 리뷰 등록 실패 시 (서비스 로직에서 false를 반환한 경우)
            System.out.println("리뷰 등록 실패: gameCode=" + gameCode); // 임시 확인
            req.setAttribute("errorMsg", "리뷰 등록에 실패했습니다. 다시 시도해주세요."); // 실패 메시지 설정

            // 실패 시, 다시 입력 폼이 있는 게임 상세 페이지로 포워드
            // AJAX 방식이므로 게임 정보나 리뷰 목록을 다시 로드할 필요 없음
            req.getRequestDispatcher("main/gameDetails.tiles").forward(req, resp);
            // 포워드 후에는 더 이상 다른 작업을 하지 않으므로 여기서 종료.
        }
	`	*/
    }
}