package com.gemdori.main.service;

import java.util.List;

import com.gemdori.main.SearchDTO;
import com.gemdori.main.vo.GameVO;

public interface GameService {
    /** 필터만 담긴 DTO와 offset, limit을 받아 결과 반환 */
    List<GameVO> searchGames(SearchDTO dto, int offset, int limit);
    int countSearchGames(SearchDTO dto);
    GameVO getGameByCode(String gameCode);
    List<GameVO> getLatestGames();
    List<GameVO> getAllGames();
}
