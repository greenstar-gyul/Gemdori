package com.gemdori.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gemdori.common.Control;
import com.gemdori.community.vo.PostVO;

public class CommunityControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // 게시글 하나 임시로 만들어서 request에 담기
        PostVO post = new PostVO();
        post.setCategory("공지사항");
        post.setDate("2025-04-17");
        post.setTitle("환영합니다!");
        post.setContent("GemDori 커뮤니티에 오신 것을 환영합니다.");
        post.setImage("img/blog/header-1.jpg");  // 경로는 실제 static 자원 위치에 맞게 조정

        req.setAttribute("post", post);

        // community.tiles 로 포워딩
        req.getRequestDispatcher("community/community.tiles").forward(req, resp);
    }
}
