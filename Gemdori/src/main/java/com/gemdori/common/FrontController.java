package com.gemdori.common;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gemdori.main.MainControl;
import com.gemdori.main.SearchGamesControl;
import com.gemdori.purchase.CartPageControl;
import com.gemdori.purchase.CheckOutControl;
import com.gemdori.purchase.GamePackageControl;

public class FrontController extends HttpServlet {
	// 요청url <=> 실행컨트롤.
	Map<String, Control> map;

	// 생성자.
	public FrontController() {
		map = new HashMap<String, Control>();
	}

	// init
	@Override
	public void init(ServletConfig config) throws ServletException {
		map.put("/main.do", new MainControl());

		map.put("/gamePackage.do", new GamePackageControl());
		map.put("/cartPage.do", new CartPageControl());
		map.put("/checkout.do", new CheckOutControl());
		map.put("/searchGames.do", new SearchGamesControl());

	}

	// service.
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		String context = req.getContextPath();
		String page = uri.substring(context.length()); 

		Control sub = map.get(page); // 키(url) => control 반환.
		sub.exec(req, resp);
	}
}