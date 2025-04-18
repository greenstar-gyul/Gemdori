package com.gemdori.community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gemdori.common.Control;

public class PostControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글쓰기 화면으로 이동
		req.getRequestDispatcher("community/post.tiles").forward(req, resp);
	}
}

