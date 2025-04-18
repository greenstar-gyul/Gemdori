<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Base64"%>
<%@ page import="java.util.Base64.Encoder"%>
<%@ page import="java.net.*"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="org.json.simple.parser.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.nio.charset.StandardCharsets"%>

<%
// 먼저 요청 파라미터 받기
String orderId = request.getParameter("orderId");
String paymentKey = request.getParameter("paymentKey");
String amount = request.getParameter("amount");

// API 호출 준비
String secretKey = "test_sk_zXLkKEypNArWmo50nX3lmeaxYG5R:";
Encoder encoder = Base64.getEncoder();
byte[] encodedBytes = encoder.encode(secretKey.getBytes("UTF-8"));
String authorizations = "Basic " + new String(encodedBytes, 0, encodedBytes.length);

// URL 인코딩
paymentKey = URLEncoder.encode(paymentKey, StandardCharsets.UTF_8);

// API 연결 설정
URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
HttpURLConnection connection = (HttpURLConnection) url.openConnection();
connection.setRequestProperty("Authorization", authorizations);
connection.setRequestProperty("Content-Type", "application/json");
connection.setRequestMethod("POST");
connection.setDoOutput(true);

// 요청 데이터 설정
JSONObject obj = new JSONObject();
obj.put("paymentKey", paymentKey);
obj.put("orderId", orderId);
obj.put("amount", amount);

// 요청 보내기
OutputStream outputStream = connection.getOutputStream();
outputStream.write(obj.toString().getBytes("UTF-8"));

// 응답 처리
int code = connection.getResponseCode();
boolean isSuccess = code == 200 ? true : false;
InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();
Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
JSONParser parser = new JSONParser();
JSONObject jsonObject = (JSONObject) parser.parse(reader);
responseStream.close();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>결제 결과</title>
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
</head>
<body>
    <section>
        <% if (isSuccess) { %>
            <h1>결제 성공</h1>
            <p>결과 데이터 : <%= jsonObject.toJSONString() %></p>
            <p>orderName : <%= jsonObject.get("orderName") %></p>
            <p>method : <%= jsonObject.get("method") %></p>
            <p>
            <% if(jsonObject.get("method").equals("카드")) { 
                out.println(((JSONObject)jsonObject.get("card")).get("number"));
            } %>
            <% if(jsonObject.get("method").equals("가상계좌")) {
                out.println(((JSONObject)jsonObject.get("virtualAccount")).get("accountNumber"));
            } %>
            <% if(jsonObject.get("method").equals("계좌이체")) {
                out.println(((JSONObject)jsonObject.get("transfer")).get("bank"));
            } %>
            <% if(jsonObject.get("method").equals("휴대폰")) {
                out.println(((JSONObject)jsonObject.get("mobilePhone")).get("customerMobilePhone"));
            } %>
            </p>
        <% } else { %>
            <h1>결제 실패</h1>
            <p><%= jsonObject.get("message") %></p>
            <span>에러코드: <%= jsonObject.get("code") %></span>
        <% } %>
    </section>
</body>
</html>