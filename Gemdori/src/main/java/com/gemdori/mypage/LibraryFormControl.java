package com.gemdori.mypage;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;
import com.gemdori.member.vo.UserFullVO;
import com.gemdori.mypage.service.MyPageService;
import com.gemdori.mypage.service.MyPageServiceImpl;
import com.gemdori.purchase.vo.PurchaseHistoryVO;

public class LibraryFormControl implements Control {
	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser");
		if (loginUser == null) {
			resp.sendRedirect("loginForm.do");
			return;
		}
		
		String userCode = loginUser.getUserCode();
		
		// MyPageService 이용하여 모든 구매 내역 가져오기
		MyPageService service = new MyPageServiceImpl();
		List<PurchaseHistoryVO> purchases = service.getAllPurchases(userCode);
		
		// 데이터 request에 저장
		req.setAttribute("user", loginUser);
		req.setAttribute("purchases", purchases);
		
		// 라이브러리 JSP 이동
		req.getRequestDispatcher("/mypage/library.tiles").forward(req, resp);
		System.out.println("library.do");
	}
}