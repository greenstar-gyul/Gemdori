package com.gemdori.main.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.gemdori.common.DataSource;
import com.gemdori.main.SearchDTO;
import com.gemdori.main.mapper.GameMapper;
import com.gemdori.main.vo.GameVO;

public class GameServiceImpl implements GameService {

    private GameMapper gameMapper;

    public GameServiceImpl() {
    	SqlSession session = DataSource.getInstance().openSession(true);
        this.gameMapper = session.getMapper(GameMapper.class);
    }

    @Override
    public List<GameVO> searchGames(SearchDTO dto, int offset, int limit) {
        Map<String, Object> map = new HashMap<String, Object>();
        int start = offset;
        int end = offset + limit;
        map.put("dto", dto);
        map.put("startRow", start);
        map.put("endRow", end);
        return gameMapper.searchGames(map);
    }


    @Override
    public int countSearchGames(SearchDTO dto) {
        return gameMapper.countSearchGames(dto);
    }
    
    @Override
    public GameVO getGameByCode(String gameCode) {
        // TODO Auto-generated method stub
        return gameMapper.getGameByCode(gameCode);
    }

    @Override
    public List<GameVO> getLatestGames() {
        return gameMapper.getLatestGames();
    }

    @Override
    public List<GameVO> getAllGames() {
        return gameMapper.getAllGames();
    }

    @Override
    public boolean updateGameRating(String gameCode) {
        return gameMapper.updateGameRating(gameCode) > 0;
    }

    @Override
    public double getGameRating(String gameCode) {
        return gameMapper.getGameRating(gameCode);
    }

    @Override
    public List<GameVO> getBestGames() {
        List<String> gameCodeList = gameMapper.getBestGameCodeList();
        List<GameVO> bestList = new ArrayList<GameVO>();
        for (String gameCode : gameCodeList) {
            bestList.add(getGameByCode(gameCode));
        }
        return bestList;
    }
}
