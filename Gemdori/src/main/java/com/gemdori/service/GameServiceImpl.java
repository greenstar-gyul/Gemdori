package com.gemdori.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.gemdori.common.DataSource;
import com.gemdori.main.SearchDTO;
import com.gemdori.main.mapper.GameMapper;
import com.gemdori.vo.GameVO;

public class GameServiceImpl implements GameService {

    private GameMapper gameMapper;

    public GameServiceImpl() {
    	SqlSession session = DataSource.getInstance().openSession(true);
        this.gameMapper = session.getMapper(GameMapper.class);
    }

    @Override
    public List<GameVO> searchGames(SearchDTO dto, int offset, int limit) {
        return gameMapper.searchGames(dto, offset, limit);
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
} 
