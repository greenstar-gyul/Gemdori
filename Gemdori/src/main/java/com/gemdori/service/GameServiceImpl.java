package com.gemdori.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.gemdori.common.DataSource;
import com.gemdori.main.mapper.GameMapper;
import com.gemdori.vo.GameVO;

public class GameServiceImpl implements GameService {

    private GameMapper gameMapper;

    public GameServiceImpl() {
    	SqlSession session = DataSource.getInstance().openSession(true);
        this.gameMapper = session.getMapper(GameMapper.class);
    }

    @Override
    public GameVO getGameByCode(String gameCode) {
        return gameMapper.getGameByCode(gameCode);
    }

    @Override
    public List<GameVO> getAllGames() {
        return gameMapper.getAllGames();
    }

    @Override
    public List<GameVO> getGamesByGenre(String genre) {
        return gameMapper.getGamesByGenre(genre);
    }

    @Override
    public List<GameVO> getGamesByPriceRange(int min, int max) {
        Map<String, Integer> range = new HashMap<>();
        range.put("min", min);
        range.put("max", max);
        return gameMapper.getGamesByPriceRange(range);
    }

    @Override
    public List<GameVO> getDiscountedGames() {
        return gameMapper.getDiscountedGames();
    }

    @Override
    public List<GameVO> getDLCsByGame(String baseGameTitle) {
        return gameMapper.getDLCsByGame(baseGameTitle);
    }

    @Override
    public GameVO getGameWithRating(String gameCode) {
        return gameMapper.getGameWithRating(gameCode);
    }

    @Override
    public List<GameVO> getPagedGames(int offset, int limit) {
        Map<String, Integer> page = new HashMap<>();
        page.put("offset", offset);
        page.put("limit", limit);
        return gameMapper.getPagedGames(page);
    }

    @Override
    public List<GameVO> searchGames(String keyword) {
        return gameMapper.searchGames(keyword);
    }
} 
