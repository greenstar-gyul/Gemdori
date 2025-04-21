package com.gemdori.main;

import lombok.Data;

@Data
public class SearchDTO {
    /* 필터 파라미터 */
    private String keyword;
    private String genres;      // 복수 선택이면 List<String>도 가능
    private String prices;
    private String publishing;
    private String rating;
    private String sort;        // relevance / newest …
    
    private int page;     // 요청된 페이지 번호 (1부터)
    private int size;     // 한 페이지당 아이템 수

    private String dlc; // dlc 포함여부
}
