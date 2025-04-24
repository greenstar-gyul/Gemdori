package com.gemdori.purchase.mapper;

import java.util.List;
import com.gemdori.purchase.vo.PurchaseHistoryVO;

public interface PurchaseHistoryMapper {

    /**
     * 구매 내역 1건을 등록합니다.
     * @param historyVO 등록할 구매 내역 정보
     * @return 등록 성공 시 1, 실패 시 0
     */
    int insertPurchaseHistory(PurchaseHistoryVO historyVO);

    /**
     * 다음 구매 코드 시퀀스 값을 가져옵니다. (예: 'P' || LPAD(SEQ_PURCHASE_CODE.NEXTVAL, 7, '0'))
     * 실제 시퀀스 이름은 DB에 맞게 조정 필요.
     * @return 생성된 구매 코드 (예: P0000001)
     */
    String getNextPurchaseCode();
    
    /**
     * 특정 사용자의 최근 구매 내역을 가져옵니다.
     * @param userCode 사용자 코드
     * @param limit 조회할 최대 레코드 수
     * @return 최근 구매 내역 리스트
     */
    List<PurchaseHistoryVO> getRecentPurchasesByUser(String userCode, int limit);
    
    /**
     * 특정 사용자의 모든 구매 내역을 가져옵니다.
     * @param userCode 사용자 코드
     * @return 사용자의 전체 구매 내역 리스트
     */
    List<PurchaseHistoryVO> getAllPurchasesByUser(String userCode);
}