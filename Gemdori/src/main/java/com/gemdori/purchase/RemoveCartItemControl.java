package com.gemdori.purchase;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;
import com.gemdori.member.vo.UserFullVO;
import com.gemdori.purchase.service.GemdoriShoppingCartService;
import com.gemdori.purchase.service.GemdoriShoppingCartServiceImpl;

public class RemoveCartItemControl implements Control {
    
    private GemdoriShoppingCartService cartService;
    
    public RemoveCartItemControl() {
        this.cartService = new GemdoriShoppingCartServiceImpl();
    }
    
    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 응답 타입 설정
        resp.setContentType("text/plain; charset=UTF-8");
        PrintWriter out = resp.getWriter();
        
        HttpSession session = req.getSession();
	     // "loginUser"라는 이름으로 UserVO 객체가 저장되었다고 가정
	     UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser"); // 가져올 때 타입 캐스팅 필요
	
	     String userCode = null; // userCode 변수 초기화
	
	     // 로그인 체크 (객체가 null이 아니고, 객체 안의 userCode가 비어있지 않은지 확인)
	     if (loginUser == null || loginUser.getUserCode() == null || loginUser.getUserCode().isEmpty()) {
	         out.print("login_required");
	         return;
	     } else {
	         userCode = loginUser.getUserCode(); // 객체에서 userCode 추출
	         System.out.println("debug : 세션 객체에서 가져온 userCode = " + userCode); // 추출된 값 확인
	     }
        try {
            // cartCode 파라미터 (삭제용)
            String cartCode = req.getParameter("cartCode");
            System.out.println(cartCode);
            // cartCode 유효성 검사 (추가하면 좋음)
            if (cartCode == null || cartCode.isEmpty()) {
                out.print("invalid_param"); // cartCode가 없으면 잘못된 파라미터 응답
                return; // 처리 종료
            }

            // cartCode를 이용하여 장바구니 아이템 삭제 서비스 호출
            boolean result = cartService.removeCartItemByCartCode(cartCode);

            // 결과에 따라 응답 전송
            if (result) {
                out.print("success"); // 삭제 성공
            } else {
                out.print("fail");    // 삭제 실패 (DB에서 0개 행이 삭제된 경우 등)
            }
            // ★★★ 중요: 여기서 return; 을 추가하여 더 이상 진행되지 않도록 합니다. ★★★
            return; // <--- 이 return 문이 반드시 필요합니다!

        } catch (Exception e) {
            // 데이터베이스 오류 등 예외 발생 시
            e.printStackTrace(); // 서버 로그에 에러 기록
            out.print("error");   // 클라이언트에는 "error" 응답
            return; // 처리 종료
        }

    }
}