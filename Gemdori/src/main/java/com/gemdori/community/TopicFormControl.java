package com.gemdori.community;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.gemdori.common.Control;
import com.gemdori.common.DataSource;
import com.gemdori.main.mapper.GameMapper;
import com.gemdori.main.vo.GameVO;

public class TopicFormControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	 	SqlSession sqlSession = DataSource.getInstance().openSession(true);
    	GameMapper mapper = sqlSession.getMapper(GameMapper.class);

    	List<GameVO> list = mapper.getAllGames();

        req.setAttribute("gamelist", list);
		// 글쓰기 화면으로 이동 
		req.getRequestDispatcher("community/topicRegistration.tiles").forward(req, resp);
	}
}

