package com.gemdori.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gemdori.main.SearchDTO;
import com.gemdori.vo.GameVO;

public interface GameMapper {

    List<GameVO> searchGames(@Param("dto") SearchDTO dto, @Param("offset") int offset, @Param("limit")  int limit);
    int          countSearchGames(SearchDTO dto);
    GameVO       getGameByCode(String gameCode);
    // 1. 게임 코드로 게임 정보 가져오기


    // 2. 전체 게임 목록 가져오기
    List<GameVO> getAllGames();

    // 3. 장르별 게임 목록 가져오기
    List<GameVO> getGamesByGenre(String genre);

    // 4. 가격 범위로 게임 목록 가져오기
    List<GameVO> getGamesByPriceRange(Map<String, Integer> priceRange);

    // 5. 할인 중인 게임 목록 가져오기
    List<GameVO> getDiscountedGames();

    // 6. 특정 게임의 DLC 목록 가져오기
    List<GameVO> getDLCsByGame(String baseGameTitle);

    // 7. 게임 정보 + 평점 (별도 테이블 필요)
    GameVO getGameWithRating(String gameCode);

    // 8. 페이징 처리된 게임 목록 가져오기
    List<GameVO> getPagedGames(Map<String, Integer> page);

    // 9. 게임 검색하기
    List<GameVO> searchGames(String keyword);
    
    // 10. 최신 게임 6개 가져오기
    List<GameVO> getLatestGames();
} 
