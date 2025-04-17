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
import com.gemdori.purchase.SuccessControl;

public class FrontController extends HttpServlet {
	// �슂泥춙rl <=> �떎�뻾而⑦듃濡�.
	Map<String, Control> map;

	// �깮�꽦�옄.
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
		map.put("/success.do", new SuccessControl());
	}

	// service.
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// url vs. uri
		// http://localhost:8080/BoardWeb/board.do
		String uri = req.getRequestURI();
		// System.out.println("�슂泥� URI: " + uri); // /BoardWeb/board.do
		String context = req.getContextPath();
		String page = uri.substring(context.length()); // "/board.do"
//		System.out.println(page);

		Control sub = map.get(page); // �궎(url) => control 諛섑솚.
		sub.exec(req, resp);
	}
}