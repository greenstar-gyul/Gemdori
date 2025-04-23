package com.gemdori.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gemdori.common.Control;
import com.gemdori.community.mapper.TopicMapper;
import com.gemdori.community.vo.TopicVO;

import org.apache.ibatis.session.SqlSession;
import com.gemdori.common.DataSource;

public class TopicDetailControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String topicCode = req.getParameter("topicCode"); // 예: "T0001"
		
		
		SqlSession session = DataSource.getInstance().openSession(); // 필수
		TopicMapper mapper = session.getMapper(TopicMapper.class); // 필수
		
		TopicVO topic = mapper.selectTopic(topicCode); // 글 하나 조회

		req.setAttribute("topic", topic); // jsp로 넘김
		req.getRequestDispatcher("/community/topicDetails.tiles").forward(req, resp);
	}
}
