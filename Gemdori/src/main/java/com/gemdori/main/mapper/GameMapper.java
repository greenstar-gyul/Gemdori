package com.gemdori.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gemdori.main.SearchDTO;
import com.gemdori.vo.GameVO;

public interface GameMapper {

    List<GameVO> searchGames(@Param("dto") SearchDTO dto, @Param("offset") int offset, @Param("limit")  int limit);
    int          countSearchGames(SearchDTO dto);
    GameVO       getGameByCode(String gameCode);
} 
