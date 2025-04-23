package com.gemdori.purchase;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.gemdori.common.Control;

public class PaymentFailControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    // 토스페이먼츠에서 전달된 실패 정보
	    String code = req.getParameter("code");
	    String message = req.getParameter("message");
	    String orderId = req.getParameter("orderId");
	    
	    // 직접 구매 파라미터 확인
	    String directBuy = req.getParameter("directBuy");
	    String gameCode = req.getParameter("gameCode");
	    
	    System.out.println("결제 실패: code=" + code + ", message=" + message + ", orderId=" + orderId);
	    
	    // 기본값 설정
	    if (code == null || code.isEmpty()) {
	        code = "UNKNOWN_ERROR";
	    }
	    
	    if (message == null || message.isEmpty()) {
	        message = "알 수 없는 오류가 발생했습니다.";
	    }
	    
	    // 에러 정보를 JSON 객체로 생성
	    JSONObject failInfo = new JSONObject();
	    failInfo.put("code", code);
	    failInfo.put("message", message);
	    failInfo.put("orderId", orderId);
	    
	    // 화면에 실패 정보 전달
	    req.setAttribute("isSuccess", false);
	    req.setAttribute("jsonObject", failInfo);
	    req.setAttribute("directBuy", directBuy);
	    req.setAttribute("gameCode", gameCode);
	    
	    // 실패 화면으로 이동
	    req.getRequestDispatcher("purchase/success.tiles").forward(req, resp);
	}
}