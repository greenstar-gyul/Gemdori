package com.gemdori.main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gemdori.common.Control;
import com.gemdori.main.service.GameService;
import com.gemdori.main.service.GameServiceImpl;
import com.gemdori.main.vo.GameVO;

public class GameDetailsControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
        String gameCode = req.getParameter("gameCode");

        GameService service = new GameServiceImpl();
        GameVO game = service.getGameByCode(gameCode);

         req.setAttribute("game", game);
        req.getRequestDispatcher("main/gameDetails.tiles").forward(req, resp);
	}

}
