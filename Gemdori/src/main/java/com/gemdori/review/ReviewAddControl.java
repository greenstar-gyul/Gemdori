package com.gemdori.review;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;
import com.gemdori.member.vo.UserProfileVO;


public class ReviewAddControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		// 폼에서 전달된 값들
		String gameCode = req.getParameter("gameCode");
		int rating = Integer.parseInt(req.getParameter("rating"));
		String reviewContents = req.getParameter("reviewContents");
		
		// 로그인한 유저 정보 가져오기
		HttpSession session = req.getSession();
		UserProfileVO loginUser = (UserProfileVO) session.getAttribute("loginUser");
		
		if(loginUser == null) {
			resp.sendRedirect("member/login.tiles");
		}
		String userCode = loginUser.getUserCode();
		
		// 리뷰 정보 VO에 담기 (리뷰코드는 DB에서 자동 증가 (AUTO INCREMENT or SEQUENCE))
		ReviewVO reviewVO = new ReviewVO();
		reviewVO.setGameCode(gameCode);
		reviewVO.setUserCode(loginUser.getUserCode());
		reviewVO.setRating(rating);
		reviewVO.setReviewContents(reviewContents);
		
		
		
		


	}

}
