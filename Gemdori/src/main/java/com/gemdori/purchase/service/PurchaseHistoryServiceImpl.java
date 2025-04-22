package com.gemdori.purchase.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory; // 추가

import com.gemdori.common.MybatisSessionFactory; // 제공해주신 클래스 임포트
import com.gemdori.purchase.mapper.PurchaseHistoryMapper;
import com.gemdori.purchase.vo.GemdoriShoppingCartVO;
import com.gemdori.purchase.vo.PurchaseHistoryVO;
import com.google.gson.JsonObject;

public class PurchaseHistoryServiceImpl implements PurchaseHistoryService {

    // SqlSessionFactory를 클래스 변수로 가지고 있는 것이 더 효율적일 수 있으나,
    // 여기서는 매번 getInstance()를 호출하는 방식으로 작성합니다.
    private final SqlSessionFactory sqlSessionFactory = MybatisSessionFactory.getInstance();

    @Override
    public boolean recordPaidPurchase(String userCode, List<GemdoriShoppingCartVO> cartItems, JsonObject tossPaymentData) throws Exception {
        // SqlSession을 try-with-resources 구문으로 관리하면 자동으로 close() 호출됨
        // 또는 수동으로 finally 블록에서 close() 해야 함. 여기서는 수동 관리 예시.
        SqlSession sqlSession = sqlSessionFactory.openSession(); // false 옵션: 수동 커밋
        boolean allSuccess = true;
        try {
            PurchaseHistoryMapper mapper = sqlSession.getMapper(PurchaseHistoryMapper.class);
            String paymentMethod = tossPaymentData.get("method") != null ? tossPaymentData.get("method").getAsString() : "UNKNOWN";
            String approvedAt = tossPaymentData.get("approvedAt") != null ? tossPaymentData.get("approvedAt").getAsString() : getCurrentDateTimeString();

            for (GemdoriShoppingCartVO cartItem : cartItems) {
                PurchaseHistoryVO historyVO = new PurchaseHistoryVO();
                String purchaseCode = mapper.getNextPurchaseCode();

                // ... (historyVO 필드 설정 로직은 동일) ...
                historyVO.setPurchaseCode(purchaseCode);
                historyVO.setUserCode(userCode);
                historyVO.setGameCode(cartItem.getGameCode());
                // ... (나머지 필드 설정) ...
                historyVO.setPurchaseDate(formatIsoDateTime(approvedAt));
                historyVO.setPrice(cartItem.getGameSalePrice() > 0 ? cartItem.getGameSalePrice() : cartItem.getGamePrice());
                historyVO.setDiscountRate(calculateDiscountRate(cartItem.getGamePrice(), historyVO.getPrice()));
                historyVO.setPaymentMethod(translatePaymentMethod(paymentMethod));
                historyVO.setPurchaseStatus(1);

                int result = mapper.insertPurchaseHistory(historyVO);
                if (result == 0) {
                    allSuccess = false;
                    throw new Exception("구매 내역 등록 실패: user=" + userCode + ", game=" + cartItem.getGameCode());
                }
            }

            if (allSuccess) {
                sqlSession.commit(); // 모든 작업 성공 시 커밋
                System.out.println("Paid purchase recorded successfully. Committing transaction.");
            } else {
                sqlSession.rollback(); // 하나라도 실패 시 롤백
                 System.out.println("Paid purchase recording failed. Rolling back transaction.");
            }
        } catch (Exception e) {
            sqlSession.rollback(); // 예외 발생 시 롤백
             System.err.println("Exception during paid purchase recording. Rolling back transaction.");
            throw e; // 예외 다시 던지기
        } finally {
            if (sqlSession != null) {
                sqlSession.close(); // SqlSession 반드시 닫기
            }
        }
        return allSuccess;
    }


    @Override
    public boolean recordFreePurchase(String userCode, String orderId, List<GemdoriShoppingCartVO> cartItems) throws Exception {
         SqlSession sqlSession = sqlSessionFactory.openSession(); // false 옵션: 수동 커밋
         boolean allSuccess = true;
         String currentDateTime = getCurrentDateTimeString();

         try {
             PurchaseHistoryMapper mapper = sqlSession.getMapper(PurchaseHistoryMapper.class);
             for (GemdoriShoppingCartVO cartItem : cartItems) {
                  // ... (0원 상품 가격 확인 등 로직 동일) ...

                 PurchaseHistoryVO historyVO = new PurchaseHistoryVO();
                 String purchaseCode = mapper.getNextPurchaseCode();

                 // ... (historyVO 필드 설정 로직은 동일) ...
                 historyVO.setPurchaseCode(purchaseCode);
                 historyVO.setUserCode(userCode);
                 historyVO.setGameCode(cartItem.getGameCode());
                 // ... (나머지 필드 설정) ...
                 historyVO.setPurchaseDate(currentDateTime);
                 historyVO.setPrice(0);
                 historyVO.setDiscountRate(100);
                 historyVO.setPaymentMethod("무료");
                 historyVO.setPurchaseStatus(1);

                 int result = mapper.insertPurchaseHistory(historyVO);
                 if (result == 0) {
                     allSuccess = false;
                     throw new Exception("0원 구매 내역 등록 실패: user=" + userCode + ", game=" + cartItem.getGameCode());
                 }
             }

             if (allSuccess) {
                 sqlSession.commit();
                 System.out.println("Free purchase recorded successfully. Committing transaction.");
             } else {
                 sqlSession.rollback();
                 System.out.println("Free purchase recording failed. Rolling back transaction.");
             }
         } catch (Exception e) {
             sqlSession.rollback();
             System.err.println("Exception during free purchase recording. Rolling back transaction.");
             throw e;
         } finally {
            if (sqlSession != null) {
                 sqlSession.close(); // SqlSession 반드시 닫기
            }
         }
         return allSuccess;
    }

    // --- Helper Methods (기존 내용과 동일) ---
    // getCurrentDateTimeString(), calculateDiscountRate(), formatIsoDateTime(), translatePaymentMethod()
    // ... (Helper 메소드 코드는 여기에 그대로 유지) ...

     // 현재 시간 문자열 (YYYY-MM-DD HH:MM:SS) 반환
    private String getCurrentDateTimeString() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(new Date());
    }

    // 할인율 계산 (원가, 판매가 기준)
    private int calculateDiscountRate(int originalPrice, int salePrice) {
        if (originalPrice <= 0 || originalPrice <= salePrice) {
            return 0; // 할인 없음 또는 오류
        }
        // 소수점 버림 (또는 반올림)
        return (int) Math.floor(((double)(originalPrice - salePrice) / originalPrice) * 100);
    }

    // Toss ISO 8601 날짜 형식을 DB 형식(YYYY-MM-DD HH:MM:SS)으로 변환 (필요 시 구현)
    private String formatIsoDateTime(String isoDateTime) {
         // 예: "2024-04-22T14:30:00+09:00" -> "2024-04-22 14:30:00"
         if (isoDateTime != null && isoDateTime.length() >= 19) { // 길이 체크 수정
             try {
                // T와 타임존 정보 제거
                 String formatted = isoDateTime.substring(0, 19).replace("T", " ");
                 // 간단한 유효성 검사 추가 (예: yyyy-MM-dd HH:mm:ss 형식 확인)
                 if (formatted.matches("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}")) {
                      return formatted;
                 } else {
                      System.err.println("ISO DateTime 포맷 변환 후 유효하지 않음: " + formatted);
                      return getCurrentDateTimeString(); // 형식 안 맞으면 현재 시간
                 }
             } catch (Exception e) {
                 System.err.println("ISO DateTime 포맷 변환 오류: " + isoDateTime + ", 오류: " + e.getMessage());
                 return getCurrentDateTimeString(); // 변환 실패 시 현재 시간 사용
             }
         }
         System.err.println("ISO DateTime 형식이 아니거나 null: " + isoDateTime);
         return getCurrentDateTimeString(); // Null 이거나 형식 안 맞으면 현재 시간
    }

    // Toss 결제수단 코드를 알아보기 쉬운 이름으로 변환 (선택 사항)
    private String translatePaymentMethod(String methodCode) {
        if (methodCode == null) return "정보없음";
        switch (methodCode.toLowerCase()) {
            case "card": return "카드";
            case "virtual_account": return "가상계좌";
            case "transfer": return "계좌이체";
            case "mobile_phone": return "휴대폰";
            case "tosspay": return "토스페이";
            // 필요시 다른 결제수단 추가
            default: return methodCode; // 모르는 코드는 그대로 반환
        }
    }
}