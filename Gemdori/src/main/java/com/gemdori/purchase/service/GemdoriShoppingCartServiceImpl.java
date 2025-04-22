package com.gemdori.purchase.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.gemdori.common.DataSource;
import com.gemdori.purchase.mapper.GemdoriShoppingCartMapper;
import com.gemdori.purchase.vo.GemdoriShoppingCartVO;

import lombok.Data;

@Data
public class GemdoriShoppingCartServiceImpl implements GemdoriShoppingCartService {
    
    private GemdoriShoppingCartMapper mapper;
    
    public GemdoriShoppingCartServiceImpl() {
    	SqlSession session = DataSource.getInstance().openSession(true);
    	this.mapper = session.getMapper(GemdoriShoppingCartMapper.class);
	}
    
    @Override
    public List<GemdoriShoppingCartVO> getCartItemsByUser(String userCode) {
        return mapper.SelectCartItemsByUser(userCode);
    }
    
    @Override
    public boolean addItemToCart(GemdoriShoppingCartVO item) {
        return mapper.insertCartitem(item) > 0;
    }
    
    @Override
    public boolean removeCartItemByCartCode(String cartCode) {
        // 필요하다면 여기에 추가적인 검증 로직을 넣을 수 있습니다.
        // 새로 추가한 매퍼 메소드를 호출합니다.
        return mapper.deleteCartItemByCartCode(cartCode) > 0;
    }
    @Override
    public boolean clearCart(String userCode) {
        return mapper.clearCartByUser(userCode) > 0;
    }
    
    @Override
    public int getCartItemCount(String userCode) {
        return mapper.selectCartItemCountByUser(userCode);
    }
    
    @Override
    public int getCartTotalAmount(String userCode) {
        try {
            Integer result = mapper.selectCartTotalAmount(userCode);
            return (result != null) ? result : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0; // 에러 발생 시 0 반환
        }
    }

    @Override
    public int getCartDiscountAmount(String userCode) {
        try {
            Integer result = mapper.selectCartDiscountAmount(userCode);
            return (result != null) ? result : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0; // 에러 발생 시 0 반환
        }
    }
    
    @Override
    public boolean checkExistingCart(String userCode, String gameCode) {
        int count = mapper.checkExistingCart(userCode, gameCode);
        return count > 0;
    }
}