<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.gemdori.purchase.vo.GemdoriShoppingCartVO" %>
<%@ page import="com.gemdori.purchase.mapper.GemdoriShoppingCartMapper" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>

<%
    // 결과 기본값 설정
    String result = "false";
    
    // 로그인 체크
    String userCode = (String) session.getAttribute("userCode");
    
    if (userCode != null && !userCode.isEmpty()) {
        try {
            // 파라미터 받기
            String gameCode = request.getParameter("gameCode");
            
            if (gameCode != null && !gameCode.isEmpty()) {
                // Spring WebApplicationContext에서 Mapper 가져오기
                WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);
                GemdoriShoppingCartMapper cartMapper = context.getBean(GemdoriShoppingCartMapper.class);
                
                // VO 객체 생성 및 값 설정
                GemdoriShoppingCartVO cartVO = new GemdoriShoppingCartVO();
                cartVO.setUserCode(userCode);
                cartVO.setGameCode(gameCode);
                
                // 이미 장바구니에 있는지 확인
                int existCount = cartMapper.checkExistingCart(userCode, gameCode);
                
                // 결과 설정
                result = (existCount > 0) ? "true" : "false";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // JSON 형식으로 결과 출력
    response.setContentType("text/plain");
    out.print(result);
%>