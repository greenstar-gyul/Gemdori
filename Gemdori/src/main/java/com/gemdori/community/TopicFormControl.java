package com.gemdori.community;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import com.gemdori.common.Control;
import com.gemdori.common.DataSource;
import com.gemdori.main.mapper.GameMapper;
import com.gemdori.main.vo.GameVO;
import com.gemdori.member.vo.UserFullVO;

public class TopicFormControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	 	SqlSession sqlSession = DataSource.getInstance().openSession(true);
    	GameMapper mapper = sqlSession.getMapper(GameMapper.class);
    	 HttpSession session = req.getSession(false);

         UserFullVO loginUser = null; 
    	List<GameVO> list = mapper.getAllGames();
		String gameCode = req.getParameter("gameCode");
        req.setAttribute("gamelist", list);
		req.setAttribute("gameCode", gameCode);
		if (session != null) {
            // 세션에서 "loginUser"라는 이름으로 저장된 객체를 가져옵니다.
            // (주의!) "loginUser"는 실제 로그인 처리 시 session.setAttribute("loginUser", ...) 했던 이름과 동일해야 합니다.
            // 가져온 객체를 UserProfileVO 타입으로 형변환 합니다. (로그인 시 UserProfileVO 객체를 저장했다고 가정)
            Object sessionAttribute = session.getAttribute("loginUser");
            if (sessionAttribute instanceof UserFullVO) { // 타입 안정성을 위해 instanceof 확인 추가
                loginUser = (UserFullVO) sessionAttribute; // 로그인을 할 때 "글 쓰기 가 가능하도록 하는 로직 추가"
            }
            System.out.println("로그인 정보: " + loginUser);
        }
    	if (loginUser == null) {
    	    // 로그인 안 된 상태라면 로그인 페이지로 리다이렉트 (혹은 에러 메시지 출력)
    	    resp.sendRedirect("loginForm.do"); // 또는 포워딩으로 안내 메시지
    	    return;
    	}
		// 글쓰기 화면으로 이동 
		req.getRequestDispatcher("community/topicRegistration.tiles").forward(req, resp);
	}
}

