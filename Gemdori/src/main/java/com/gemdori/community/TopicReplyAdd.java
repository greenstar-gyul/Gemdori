package com.gemdori.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import com.gemdori.common.Control;
import com.gemdori.common.DataSource;
import com.gemdori.community.mapper.ReplyMapper;
import com.gemdori.community.vo.ReplyVO;
import com.gemdori.member.vo.UserFullVO;

public class TopicReplyAdd implements Control {
	
	SqlSession sqlSession = DataSource.getInstance().openSession(true);
	ReplyMapper mapper = sqlSession.getMapper(ReplyMapper.class);
	
	

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	String topicCode = req.getParameter("topicCode");
    	String content = req.getParameter("comment");
    	  HttpSession session = req.getSession(false);

          UserFullVO loginUser = null; // 세션에서 가져올 사용자 정보를 담을 변수
        // 요청 파라미터에서 댓글 정보 가져오기
    	if (session != null) {
            // 세션에서 "loginUser"라는 이름으로 저장된 객체를 가져옵니다.
            // (주의!) "loginUser"는 실제 로그인 처리 시 session.setAttribute("loginUser", ...) 했던 이름과 동일해야 합니다.
            // 가져온 객체를 UserProfileVO 타입으로 형변환 합니다. (로그인 시 UserProfileVO 객체를 저장했다고 가정)
            Object sessionAttribute = session.getAttribute("loginUser");
            if (sessionAttribute instanceof UserFullVO) { // 타입 안정성을 위해 instanceof 확인 추가
                loginUser = (UserFullVO) sessionAttribute;
            }
            System.out.println("로그인 정보: " + loginUser);
        }

        try {
            // 예: MyBatis 또는 JDBC를 사용하여 게시글을 DB에 저장
            // PostDAO.savePost(title, content);
            ReplyVO reply = new ReplyVO();
            reply.setTopicCode(topicCode);
            reply.setCommentContents(content);
            reply.setUserCode(loginUser.getUserCode());
        	
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

