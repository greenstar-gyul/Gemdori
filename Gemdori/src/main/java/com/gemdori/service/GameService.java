package com.gemdori.service;

import java.util.List;
import java.util.Map;

import com.gemdori.vo.GameVO;

public interface GameService {

    // 1. 게임 코드로 게임 정보 가져오기
    GameVO getGameByCode(String gameCode);

    // 2. 전체 게임 목록 가져오기
    List<GameVO> getAllGames();

    // 3. 장르별 게임 목록 가져오기
    List<GameVO> getGamesByGenre(String genre);

    // 4. 가격 범위로 게임 목록 가져오기
    List<GameVO> getGamesByPriceRange(int min, int max);

    // 5. 할인 중인 게임 목록 가져오기
    List<GameVO> getDiscountedGames();

    // 6. 특정 게임의 DLC 목록 가져오기
    List<GameVO> getDLCsByGame(String baseGameTitle);

    // 7. 게임 정보와 평점 가져오기
    GameVO getGameWithRating(String gameCode);

    // 8. 페이징 처리된 게임 목록 가져오기
    List<GameVO> getPagedGames(int offset, int limit);

    // 9. 게임 검색
    List<GameVO> searchGames(String keyword);
} 