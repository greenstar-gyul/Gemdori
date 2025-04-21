package com.gemdori.community;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.gemdori.common.Control;

public class TopicregistrationControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 폼에서 입력받은 데이터
        String topicTitle = req.getParameter("topicTitle");
        String topicContents = req.getParameter("topicContents");

        // 데이터 유효성 검사 (필요시)
        if (topicTitle == null || topicTitle.trim().isEmpty() || topicContents == null || topicContents.trim().isEmpty()) {
            req.setAttribute("errorMessage", "제목과 내용은 필수입니다.");
            // 오류 발생 시, 다시 폼을 보이기 위해 포워딩
            req.getRequestDispatcher("post.do").forward(req, resp);
            return;
        }

        // DB 저장 로직 예시
        try {
            // 예: MyBatis 또는 JDBC를 사용하여 게시글을 DB에 저장
            // PostDAO.savePost(title, content);

        	//table 에 insert 할 mapper 호출 필요 // TopicMapper.xml 로 했는데 좋은 이름
        	
            // 성공적으로 저장되면, 리스트 페이지로 리다이렉트
            resp.sendRedirect("topicList.do");  // 이름을 commentList.do로 하는 게 좋겠다
        } catch (Exception e) {
            // 예외 처리 (DB에 저장 실패 등)
            req.setAttribute("errorMessage", "게시글 저장에 실패했습니다.");
            req.getRequestDispatcher("/WEB-INF/community/post.jsp").forward(req, resp);
        }
    }
}
