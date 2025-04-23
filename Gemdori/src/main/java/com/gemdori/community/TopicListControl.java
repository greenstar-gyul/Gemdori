package com.gemdori.community;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.gemdori.common.Control;
import com.gemdori.common.DataSource;
import com.gemdori.community.mapper.TopicMapper;
import com.gemdori.community.vo.TopicVO;

public class TopicListControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // SqlSession을 사용하여 DB에 접근
        SqlSession sqlSession = DataSource.getInstance().openSession();
        TopicMapper mapper = sqlSession.getMapper(TopicMapper.class);
        String gameCode = req.getParameter("gameCode");
        List<TopicVO> topicList = mapper.selectTopicList(gameCode);
        req.setAttribute("topicList", topicList);
        req.setAttribute("gameCode", gameCode);
        req.getRequestDispatcher("community/topicList.tiles").forward(req, resp);

        
    }
}

