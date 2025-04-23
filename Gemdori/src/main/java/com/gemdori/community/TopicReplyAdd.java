package com.gemdori.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.gemdori.common.Control;
import com.gemdori.common.DataSource;
import com.gemdori.community.mapper.ReplyMapper;
import com.gemdori.community.vo.ReplyVO;

public class TopicReplyAdd implements Control {
	
	SqlSession sqlSession = DataSource.getInstance().openSession(true);
	ReplyMapper mapper = sqlSession.getMapper(ReplyMapper.class);

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	String topicCode = req.getParameter("topicCode");
        // 요청 파라미터에서 댓글 정보 가져오기
        String content = req.getParameter("comment");
        String writer = req.getParameter("author");

        try {
            // 예: MyBatis 또는 JDBC를 사용하여 게시글을 DB에 저장
            // PostDAO.savePost(title, content);
            ReplyVO reply = new ReplyVO();
            reply.setTopicCode(topicCode);
            reply.setCommentContents(content);
            reply.setUserCode(writer);
        	
            System.out.println(reply);

        	mapper.insertReply(reply);
        	
        	System.out.println("*--------------------*");
        	System.out.println(reply);
        	System.out.println("*--------------------*");
        	
        } catch (Exception e) {
            // 예외 처리 (DB에 저장 실패 등)
        	e.printStackTrace(); 
            req.setAttribute("errorMessage", "게시글 저장에 실패했습니다.");
        }
        // 에러 처리 로직 추가
        resp.sendRedirect("topicDetail.do?topicCode=" + topicCode);
    }
}

