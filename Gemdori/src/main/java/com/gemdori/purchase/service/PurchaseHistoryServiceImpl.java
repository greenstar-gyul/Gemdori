package com.gemdori.purchase.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.gemdori.common.MybatisSessionFactory;
import com.gemdori.purchase.mapper.PurchaseHistoryMapper;
import com.gemdori.purchase.vo.GemdoriShoppingCartVO;
import com.gemdori.purchase.vo.PurchaseHistoryVO;
import com.google.gson.JsonObject;

public class PurchaseHistoryServiceImpl implements PurchaseHistoryService {

    private final SqlSessionFactory sqlSessionFactory = MybatisSessionFactory.getInstance();

    @Override
    public boolean recordPaidPurchase(String userCode, List<GemdoriShoppingCartVO> cartItems, JsonObject tossPaymentData) throws Exception {
        // 기존 코드 유지
        SqlSession sqlSession = sqlSessionFactory.openSession();
        boolean allSuccess = true;
        try {
            PurchaseHistoryMapper mapper = sqlSession.getMapper(PurchaseHistoryMapper.class);
            String paymentMethod = tossPaymentData.get("method") != null ? tossPaymentData.get("method").getAsString() : "UNKNOWN";
            String approvedAt = tossPaymentData.get("approvedAt") != null ? tossPaymentData.get("approvedAt").getAsString() : getCurrentDateTimeString();

            for (GemdoriShoppingCartVO cartItem : cartItems) {
                PurchaseHistoryVO historyVO = new PurchaseHistoryVO();
                String purchaseCode = mapper.getNextPurchaseCode();

                historyVO.setPurchaseCode(purchaseCode);
                historyVO.setUserCode(userCode);
                historyVO.setGameCode(cartItem.getGameCode());
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
                sqlSession.commit();
                System.out.println("Paid purchase recorded successfully. Committing transaction.");
            } else {
                sqlSession.rollback();
                System.out.println("Paid purchase recording failed. Rolling back transaction.");
            }
        } catch (Exception e) {
            sqlSession.rollback();
            System.err.println("Exception during paid purchase recording. Rolling back transaction.");
            throw e;
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
        return allSuccess;
    }

    @Override
    public boolean recordFreePurchase(String userCode, String orderId, List<GemdoriShoppingCartVO> cartItems) throws Exception {
        // 기존 코드 유지
        SqlSession sqlSession = sqlSessionFactory.openSession();
        boolean allSuccess = true;
        String currentDateTime = getCurrentDateTimeString();

        try {
            PurchaseHistoryMapper mapper = sqlSession.getMapper(PurchaseHistoryMapper.class);
            for (GemdoriShoppingCartVO cartItem : cartItems) {
                PurchaseHistoryVO historyVO = new PurchaseHistoryVO();
                String purchaseCode = mapper.getNextPurchaseCode();

                historyVO.setPurchaseCode(purchaseCode);
                historyVO.setUserCode(userCode);
                historyVO.setGameCode(cartItem.getGameCode());
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
                sqlSession.close();
            }
        }
        return allSuccess;
    }
    
    @Override
    public List<PurchaseHistoryVO> getRecentPurchasesByUser(String userCode, int limit) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        try {
            PurchaseHistoryMapper mapper = sqlSession.getMapper(PurchaseHistoryMapper.class);
            return mapper.getRecentPurchasesByUser(userCode, limit);
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }
    
    @Override
    public List<PurchaseHistoryVO> getAllPurchasesByUser(String userCode) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        try {
            PurchaseHistoryMapper mapper = sqlSession.getMapper(PurchaseHistoryMapper.class);
            return mapper.getAllPurchasesByUser(userCode);
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }

    // Helper Methods (기존 내용 유지)
    private String getCurrentDateTimeString() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(new Date());
    }

    private int calculateDiscountRate(int originalPrice, int salePrice) {
        if (originalPrice <= 0 || originalPrice <= salePrice) {
            return 0;
        }
        return (int) Math.floor(((double)(originalPrice - salePrice) / originalPrice) * 100);
    }

    private String formatIsoDateTime(String isoDateTime) {
        if (isoDateTime != null && isoDateTime.length() >= 19) {
            try {
                String formatted = isoDateTime.substring(0, 19).replace("T", " ");
                if (formatted.matches("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}")) {
                    return formatted;
                } else {
                    System.err.println("ISO DateTime 포맷 변환 후 유효하지 않음: " + formatted);
                    return getCurrentDateTimeString();
                }
            } catch (Exception e) {
                System.err.println("ISO DateTime 포맷 변환 오류: " + isoDateTime + ", 오류: " + e.getMessage());
                return getCurrentDateTimeString();
            }
        }
        System.err.println("ISO DateTime 형식이 아니거나 null: " + isoDateTime);
        return getCurrentDateTimeString();
    }

    private String translatePaymentMethod(String methodCode) {
        if (methodCode == null) return "정보없음";
        switch (methodCode.toLowerCase()) {
            case "card": return "카드";
            case "virtual_account": return "가상계좌";
            case "transfer": return "계좌이체";
            case "mobile_phone": return "휴대폰";
            case "tosspay": return "토스페이";
            default: return methodCode;
        }
    }
}