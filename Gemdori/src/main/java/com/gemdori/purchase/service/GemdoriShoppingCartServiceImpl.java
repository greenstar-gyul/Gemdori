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
    public boolean removeCartItem(String userCode, String gameCode) {
        return mapper.deleteCartItemByUserAndGame(userCode, gameCode) > 0;
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
        return mapper.selectCartTotalAmount(userCode);
    }

    @Override
    public int getCartDiscountAmount(String userCode) {
        return mapper.selectCartDiscountAmount(userCode);
    }
}