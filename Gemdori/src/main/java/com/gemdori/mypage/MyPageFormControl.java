package com.gemdori.mypage;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;
import com.gemdori.member.vo.UserFullVO;
import com.gemdori.mypage.service.MyPageService;
import com.gemdori.mypage.service.MyPageServiceImpl;
import com.gemdori.mypage.vo.RecentReviewVO;

public class MyPageFormControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			resp.sendRedirect("loginForm.do");
			return;
		}

		String userCode = loginUser.getUserCode();

		// 최근 리뷰 3개 조회
		MyPageService service = new MyPageServiceImpl();
		List<RecentReviewVO> recentReviews = service.getRecentReviews(userCode);

		// 리뷰 + 사용자 정보 전달
		req.setAttribute("user", loginUser);
		req.setAttribute("recentReviews", recentReviews);

		
		// 마이페이지 JSP 이동
		req.getRequestDispatcher("/mypage/myPage.tiles").forward(req, resp);
		System.out.println("myPage.do");
	}

}


