package com.gemdori.main;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
    private int startPage;    // 페이지 블록 시작
    private int endPage;      // 페이지 블록 끝
    private int currentPage;  // 현재 페이지
    private int size;         // 한 페이지당 보여줄 아이템 수
    private int totalPage;    // 전체 페이지 수
    private boolean prev;     // 이전 블록 존재 여부
    private boolean next;     // 다음 블록 존재 여부

    /**
     * @param totalCnt   전체 아이템 수
     * @param currentPage 요청된 페이지 번호
     * @param size       한 페이지당 아이템 수
     */
    public PageDTO(int totalCnt, int currentPage, int size) {
        this.currentPage = currentPage;
        this.size        = size;

        // 전체 페이지 수
        this.totalPage = (int)Math.ceil(totalCnt / (double)size);

        // 10개 페이지씩 블록 처리
        this.endPage   = (int)Math.ceil(currentPage / 10.0) * 10;
        this.startPage = endPage - 9;

        // 블록 끝이 전체 페이지보다 크면 보정
        if (endPage > totalPage) {
            endPage = totalPage;
        }

        // 이전 블록, 다음 블록 존재 여부
        this.prev = startPage > 1;
        this.next = endPage < totalPage;
    }
}
