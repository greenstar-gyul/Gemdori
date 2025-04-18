package com.gemdori.main;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.gemdori.common.Control;
import com.gemdori.vo.GameVO;
import com.gemdori.common.MybatisSessionFactory;
import com.gemdori.main.mapper.GameMapper;

public class MainControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SqlSessionFactory factory = MybatisSessionFactory.getInstance();
        try (SqlSession session = factory.openSession(true)) {
        	// 최근 게임
        	GameMapper mapper = session.getMapper(GameMapper.class);
            List<GameVO> latestGameList = mapper.getLatestGames();            
            req.setAttribute("latestGameList", latestGameList);
            
        	// 인기 게임
        	
        	// 모든 게임 리스트
            List<GameVO> gameList = mapper.getAllGames();            
            req.setAttribute("gameList", gameList);
        } catch (Exception e) {
        	e.printStackTrace();
        }

        req.getRequestDispatcher("main/main.tiles").forward(req, resp);
    }
}
