package com.gemdori.community;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gemdori.common.Control;
import com.gemdori.community.vo.ReplyVO;

public class TopicReplyAdd implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 요청 파라미터에서 댓글 정보 가져오기
            String topicCode = req.getParameter("topicCode");
            String content = req.getParameter("content");
            String writer = req.getParameter("writer");

            // 댓글 객체 생성
            ReplyVO reply = new ReplyVO();
            reply.setTopicCode(topicCode);
            reply.setContent(content);
            reply.setWriter(writer);



            // 댓글 추가 후 주제 상세 페이지로 리다이렉트
            resp.sendRedirect(req.getContextPath() + "/topicDetail.do?topicCode=" + topicCode);
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 처리 로직 추가
            req.setAttribute("errorMessage", "댓글 추가에 실패했습니다.");
            req.getRequestDispatcher("/errorPage.jsp").forward(req, resp);
        }
    }
}

