package com.gemdori.community;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gemdori.main.service.GameService;
import com.gemdori.main.service.GameServiceImpl;
import org.apache.ibatis.session.SqlSession;

import com.gemdori.common.Control;
import com.gemdori.common.DataSource;
import com.gemdori.main.mapper.GameMapper;
import com.gemdori.main.vo.GameVO;

public class CommunityControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        GameService svc = new GameServiceImpl();
    	List<GameVO> list = svc.getAllGames();

        req.setAttribute("gameList", list);

        List<GameVO> popList = svc.getBestGames(12);
        req.setAttribute("popList", popList);

        // community.tiles 로 포워딩
        req.getRequestDispatcher("community/communityMain.tiles").forward(req, resp);
    }
}
