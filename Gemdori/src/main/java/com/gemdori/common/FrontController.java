
package com.gemdori.common;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.gemdori.member.MyInfoControl;
import com.gemdori.member.SendEmailControl;
import com.gemdori.member.UpdatePasswordControl;
import com.gemdori.member.UpdatePasswordFormControl;
import com.gemdori.member.UpdateProfileControl;
import com.gemdori.member.UpdateProfileFormControl;
import com.gemdori.member.VerifyEmailCodeControl;
import com.gemdori.purchase.AddToCartControl;
import com.gemdori.purchase.CartPageControl;
import com.gemdori.purchase.CheckCartControl;
import com.gemdori.purchase.CheckOutControl;
import com.gemdori.purchase.GamePackageControl;
import com.gemdori.purchase.GetCartSummaryControl;
import com.gemdori.purchase.PaymentFailControl;
import com.gemdori.purchase.PaymentSuccessControl;
import com.gemdori.purchase.RemoveCartItemControl;
import com.gemdori.purchase.SuccessControl;
import com.gemdori.purchase.TossPaymentController;
import com.gemdori.review.ReviewAddControl;
import com.gemdori.review.ReviewListControl;
import com.gemdori.review.ReviewRemoveControl;
import com.gemdori.user.TempSessionControl;


public class FrontController extends HttpServlet {
	// 요청url <=> 실행컨트롤.
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
		map.put("/reviewList.do", new ReviewListControl()); // 리뷰 목록 조회 컨트롤러
		map.put("/removeReview.do", new ReviewRemoveControl()); //  리뷰 삭제 컨트롤러

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
		// 회원정보 컨트롤
		map.put("/myInfo.do", new MyInfoControl()); // 회원정보 페이지 이동
		map.put("/updateProfileForm.do", new UpdateProfileFormControl()); // 회원정보 수정 페이지 이동
		map.put("/updateProfile.do", new UpdateProfileControl()); // 회원정보 수정 업데이트
		map.put("/updatePasswordForm.do", new UpdatePasswordFormControl()); // 회원 비밀번호 변경 페이지 이동
		map.put("/updatePassword.do", new UpdatePasswordControl()); // 회원 비밀번호 변경
		
		/* ******************************
		 * 구매 관련 요청
		 * ******************************/
		map.put("/gamePackage.do", new GamePackageControl());
		map.put("/cartPage.do", new CartPageControl());
		map.put("/checkout.do", new CheckOutControl());
		map.put("/success.do", new SuccessControl());
		map.put("/tempSession.do", new TempSessionControl());
		map.put("/addToCart.do", new AddToCartControl());
		map.put("/cartPage.do", new CartPageControl());
		map.put("/checkCart.do", new CheckCartControl());
		map.put("/removeCartItem.do", new RemoveCartItemControl());
		map.put("/tossPayment.do", new TossPaymentController());
		map.put("/paymentSuccess.do", new PaymentSuccessControl());
		map.put("/paymentFail.do", new PaymentFailControl());
		map.put("/getCartSummary.do", new GetCartSummaryControl());
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
	}
}