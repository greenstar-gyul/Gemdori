package com.gemdori.main;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gemdori.main.service.GameService;
import com.gemdori.main.service.GameServiceImpl;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.gemdori.common.Control;
import com.gemdori.main.vo.GameVO;
import com.gemdori.common.MybatisSessionFactory;
import com.gemdori.main.mapper.GameMapper;

public class MainControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("main control");

        GameService gameService = new GameServiceImpl();
        List<GameVO> latestGameList = gameService.getLatestGames();
        req.setAttribute("latestGameList", latestGameList);

        List<GameVO> bestGameList = gameService.getBestGames();
        req.setAttribute("bestGameList", bestGameList);

        List<GameVO> gameList = gameService.getAllGames();

        req.getRequestDispatcher("main/main.tiles").forward(req, resp);
    }
}
