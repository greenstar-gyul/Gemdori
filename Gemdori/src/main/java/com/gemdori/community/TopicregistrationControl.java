package com.gemdori.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.gemdori.common.Control;
import com.gemdori.common.DataSource;
import com.gemdori.community.mapper.TopicMapper;
import com.gemdori.community.vo.TopicVO;

public class TopicregistrationControl implements Control {
	
	SqlSession sqlSession = DataSource.getInstance().openSession(true);
	TopicMapper mapper = sqlSession.getMapper(TopicMapper.class);

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 폼에서 입력받은 데이터
        String topicTitle = req.getParameter("topicTitle");
        String topicContents = req.getParameter("topicContents");
        String gameCode = req.getParameter("gameCode");

        // 데이터 유효성 검사 (필요시)
        if (topicTitle == null || topicTitle.trim().isEmpty() || topicContents == null || topicContents.trim().isEmpty()) {
            req.setAttribute("errorMessage", "제목과 내용은 필수입니다.");
            // 오류 발생 시, 다시 폼을 보이기 위해 포워딩
            req.getRequestDispatcher("community/topicRegistration.tiles").forward(req, resp);
            return;
        }

        // DB 저장 로직 예시
        try {
            // 예: MyBatis 또는 JDBC를 사용하여 게시글을 DB에 저장
            // PostDAO.savePost(title, content);
        	TopicVO topic = new TopicVO();
        	topic.setGameCode(gameCode);
        	topic.setTopicTitle(topicTitle);
        	topic.setTopicContents(topicContents);
        	topic.setUserCode("U1");
        	

        	//table 에 insert 할 mapper 호출 필요 // TopicMapper.xml 로 했는데 좋은 이름
        	mapper.insertTopic(topic);
        	
            // 성공적으로 저장되면, 리스트 페이지로 리다이렉트
            resp.sendRedirect("topicList.do");  // 이름을 topicList.do로 수정
        } catch (Exception e) {
            // 예외 처리 (DB에 저장 실패 등)
        	e.printStackTrace(); 
            req.setAttribute("errorMessage", "게시글 저장에 실패했습니다.");
            req.getRequestDispatcher("community/topicRegistration.tiles").forward(req, resp);
        }
    }
}
