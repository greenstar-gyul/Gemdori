package com.gemdori.purchase.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    	SqlSession session = DataSource.getInstance().openSession(true);
        GemdoriShoppingCartMapper freshMapper = session.getMapper(GemdoriShoppingCartMapper.class);
        return mapper.SelectCartItemsByUser(userCode);
    }
    
    @Override
    public boolean addItemToCart(GemdoriShoppingCartVO item) {
        SqlSession session = DataSource.getInstance().openSession(true);
        GemdoriShoppingCartMapper freshMapper = session.getMapper(GemdoriShoppingCartMapper.class);
        boolean result = freshMapper.insertCartitem(item) > 0;
        session.commit(); // 명시적 커밋 추가
        return result;
    }
    
    @Override
    public boolean removeCartItemByCartCode(String cartCode) {
        SqlSession session = DataSource.getInstance().openSession(true);
        GemdoriShoppingCartMapper freshMapper = session.getMapper(GemdoriShoppingCartMapper.class);
        boolean result = freshMapper.deleteCartItemByCartCode(cartCode) > 0;
        session.commit(); // 명시적 커밋 추가
        return result;
    }
    @Override
    public boolean clearCart(String userCode) {
        SqlSession session = DataSource.getInstance().openSession(true);
        GemdoriShoppingCartMapper freshMapper = session.getMapper(GemdoriShoppingCartMapper.class);
        boolean result = freshMapper.clearCartByUser(userCode) > 0;
        session.commit();
        return result;
    }

    @Override
    public int getCartItemCount(String userCode) {
        SqlSession session = DataSource.getInstance().openSession(true);
        GemdoriShoppingCartMapper freshMapper = session.getMapper(GemdoriShoppingCartMapper.class);
        return freshMapper.selectCartItemCountByUser(userCode);
    }

    @Override
    public Map<String, Object> getCartTotalAmount(String userCode) {
        try {
            SqlSession session = DataSource.getInstance().openSession(true);
            GemdoriShoppingCartMapper freshMapper = session.getMapper(GemdoriShoppingCartMapper.class);
            Map<String, Object> result = freshMapper.selectCartTotals(userCode);
            return (result != null) ? result : new HashMap<>(); // null이면 빈 Map 반환
        } catch (Exception e) {
            e.printStackTrace();
            return new HashMap<>(); // 에러 발생 시 빈 Map 반환
        }
    }

    @Override
    public int getCartDiscountAmount(String userCode) {
        try {
            SqlSession session = DataSource.getInstance().openSession(true);
            GemdoriShoppingCartMapper freshMapper = session.getMapper(GemdoriShoppingCartMapper.class);
            Integer result = freshMapper.selectCartDiscountAmount(userCode);
            return (result != null) ? result : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0; // 에러 발생 시 0 반환
        }
    }

    @Override
    public boolean checkExistingCart(String userCode, String gameCode) {
        SqlSession session = DataSource.getInstance().openSession(true);
        GemdoriShoppingCartMapper freshMapper = session.getMapper(GemdoriShoppingCartMapper.class);
        int count = freshMapper.checkExistingCart(userCode, gameCode);
        return count > 0;
    }
    
    @Override
    public List<GemdoriShoppingCartVO> getGameDetailForDirectBuy(String gameCode) {
        SqlSession session = DataSource.getInstance().openSession(true);
        GemdoriShoppingCartMapper freshMapper = session.getMapper(GemdoriShoppingCartMapper.class);
        return freshMapper.selectGameDetailForDirectBuy(gameCode);
    }
}