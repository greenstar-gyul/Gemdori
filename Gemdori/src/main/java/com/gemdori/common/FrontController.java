
package com.gemdori.common;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gemdori.community.TopicDetailControl;
//import com.gemdori.community.CommunityControl;
import com.gemdori.community.TopicFormControl;
import com.gemdori.community.TopicListControl;
import com.gemdori.community.TopicregistrationControl;
import com.gemdori.main.GameDetailsControl;
import com.gemdori.main.MainControl;
import com.gemdori.main.SearchGamesControl;
import com.gemdori.member.CheckIdControl;
import com.gemdori.member.CheckIdExistsControl;
import com.gemdori.member.FindPasswordFormControl;
import com.gemdori.member.GenerateTempPasswordControl;
import com.gemdori.member.JoinControl;
import com.gemdori.member.JoinFormControl;
import com.gemdori.member.LoginControl;
import com.gemdori.member.LoginFormControl;
import com.gemdori.member.LogoutControl;
import com.gemdori.member.SendEmailControl;
import com.gemdori.member.VerifyEmailCodeControl;
import com.gemdori.purchase.CartPageControl;
import com.gemdori.purchase.CheckOutControl;
import com.gemdori.purchase.GamePackageControl;
import com.gemdori.purchase.SuccessControl;
import com.gemdori.review.ReviewAddControl;
import com.gemdori.user.TempSessionControl;


public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Map<String, Control> map;

	// 생성자.
	public FrontController() {
		map = new HashMap<String, Control>();
	}

	// init
	@Override
	public void init(ServletConfig config) throws ServletException {

		/* ******************************
		 * 메인 요청
		 * ******************************/
		map.put("/main.do", new MainControl());
		map.put("/gameDetails.do", new GameDetailsControl());
		map.put("/searchGames.do", new SearchGamesControl());
		map.put("/reviewAdd.do", new ReviewAddControl());

		/* ******************************
		 * 회원 관련 요청
		 * ******************************/
		// 회원 로그인 컨트롤
		map.put("/loginForm.do", new LoginFormControl()); // 로그인 페이지 이동
		map.put("/login.do", new LoginControl()); // 로그인
		map.put("/logout.do", new LogoutControl()); // 로그아웃
		// 회원 비밀번호 찾기
		map.put("/findPassword.do", new FindPasswordFormControl()); // 비밀번호 찾기 페이지 이동
		map.put("/findUserIdCheck.do", new CheckIdExistsControl()); // 아이디 존재 확인 후 이메일 인증 코드 전송
		map.put("/recombinationPw.do", new GenerateTempPasswordControl()); // 이메일 인증 완료 후 비밀번호 재조합
		// 회원가입 컨트롤
		map.put("/signForm.do", new JoinFormControl()); // 회원가입 페이지 이동
		map.put("/signUp.do", new JoinControl()); // 회원등록
		map.put("/checkId.do", new CheckIdControl()); // 회원가입 - 아이디 중복 확인
		map.put("/sendEmailCode.do", new SendEmailControl()); // 회원가입 - 이메일 인증코드 보내기
		map.put("/verifyEmailCode.do", new VerifyEmailCodeControl()); // 회원가입 - 이메일 인증코드 일치확인

		/* ******************************
		 * 구매 관련 요청
		 * ******************************/
		map.put("/gamePackage.do", new GamePackageControl());
		map.put("/cartPage.do", new CartPageControl());
		map.put("/checkout.do", new CheckOutControl());
		map.put("/searchGames.do", new SearchGamesControl());

		//map.put("/community.do", new CommunityControl());
		map.put("/topicform.do", new TopicFormControl()); // 2
		map.put("/topicRegistration.do", new TopicregistrationControl());
		map.put("/topicDetail.do", new TopicDetailControl());
		map.put("/success.do", new SuccessControl());
		map.put("/gameDetails.do", new GameDetailsControl());
		map.put("/topicList.do", new TopicListControl());
		map.put("/tempSession.do", new TempSessionControl());
		

	}

	// service.
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		// System.out.println("요청 URI: " + uri); // /BoardWeb/board.do
		// System.out.println("요청 URI: " + uri); // /BoardWeb/board.do
		String context = req.getContextPath();
		String page = uri.substring(context.length()); 

		Control sub = map.get(page); // 키(url) => control 반환.
		sub.exec(req, resp);
		System.out.println("요청 URI: " + uri);
		System.out.println("매핑된 컨트롤러: " + sub.getClass().getName());

	}
}