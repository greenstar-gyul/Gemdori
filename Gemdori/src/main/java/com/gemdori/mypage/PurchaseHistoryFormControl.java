package com.gemdori.mypage; // 또는 적절한 패키지

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gemdori.common.Control;
import com.gemdori.member.vo.UserFullVO;
import com.gemdori.purchase.service.PurchaseHistoryService;
import com.gemdori.purchase.service.PurchaseHistoryServiceImpl;
import com.gemdori.purchase.vo.PurchaseHistoryVO;

public class PurchaseHistoryFormControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserFullVO loginUser = (UserFullVO) session.getAttribute("loginUser");

        // 로그인 확인
        if (loginUser == null) {
            resp.sendRedirect("loginForm.do"); // 로그인 페이지로 리다이렉트
            return;
        }

        String userCode = loginUser.getUserCode();

        // PurchaseHistoryService를 사용하여 사용자의 모든 구매 내역 가져오기
        PurchaseHistoryService service = new PurchaseHistoryServiceImpl();
        List<PurchaseHistoryVO> purchaseList = service.getAllPurchasesByUser(userCode); // ServiceImpl의 해당 메소드 사용

        // 조회된 데이터를 request 객체에 저장
        req.setAttribute("user", loginUser); // 사용자 정보 (필요시)
        req.setAttribute("purchaseList", purchaseList); // 구매 내역 리스트

        // 구매 내역 JSP 페이지로 포워딩
        // tiles.xml 설정에 맞게 경로 지정 (예: "mypage/purchaseHistory")
        //req.getRequestDispatcher("/WEB-INF/mypage/purchaseHistory.jsp").forward(req, resp);
        // 또는 Tiles 설정 사용 시:
        req.getRequestDispatcher("/mypage/purchaseHistory.tiles").forward(req, resp);

        System.out.println("purchaseHistory.do for user: " + userCode + ", found: " + (purchaseList != null ? purchaseList.size() : 0) + " items.");
    }
}