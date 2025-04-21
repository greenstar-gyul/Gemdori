package com.gemdori.main;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gemdori.common.Control;
import com.gemdori.main.SearchDTO;
import com.gemdori.main.PageDTO;
import com.gemdori.main.service.GameService;
import com.gemdori.main.service.GameServiceImpl;
import com.gemdori.main.vo.GameVO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * /searchGames.do
 * - 필터 파라미터 + page, size 처리
 * - DTO에 오직 page, size만 담고
 * - 컨트롤러에서 offset 계산 후 서비스 호출
 * - PageDTO로 페이지네이션 정보 계산
 */
public class SearchGamesControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 1) 필터 & 페이징 파라미터 바인딩
        SearchDTO dto = new SearchDTO();
        dto.setKeyword(   nullToEmpty(req.getParameter("keyword")) );
        dto.setGenres(    nullToEmpty(req.getParameter("genres"))  );
        dto.setPrices(    nullToEmpty(req.getParameter("prices"))  );
        dto.setPublishing(nullToEmpty(req.getParameter("publishing")));
        dto.setRating(    nullToEmpty(req.getParameter("rating"))   );
        dto.setSort(      nullToEmpty(req.getParameter("sort"))     );
        dto.setDlc(       nullToEmpty(req.getParameter("dlc"))   );

        int page = parseInt(req.getParameter("page"), 1);
        int size = parseInt(req.getParameter("size"), 9);
        dto.setPage(page);
        dto.setSize(size);

        // 2) 전체 건수 조회
        GameService svc = new GameServiceImpl();
        int total = svc.countSearchGames(dto);

        // 3) PageDTO 생성
        PageDTO pageDTO = new PageDTO(total, page, size);

        // 4) 실제 검색 수행 (offset 계산)
        int offset = (page - 1) * size;
        List<GameVO> games = svc.searchGames(dto, offset, size);

        // ✅ JSON 요청이면 JSON으로 응답
        if ("1".equals(req.getParameter("ajax"))) {
            resp.setContentType("text/json; charset=UTF-8");

            Map<String, Object> result = new HashMap<>();
            result.put("items", games);
            result.put("total", total);

            Gson gson = new GsonBuilder().setPrettyPrinting().create();
            String json = gson.toJson(result);
            resp.getWriter().write(json);
            return;
        }

        // 5) View에 값 전달
        req.setAttribute("games",    games);
        req.setAttribute("pageDTO",  pageDTO);
        req.setAttribute("keyword",  dto.getKeyword());
        req.setAttribute("genres",   dto.getGenres());
        req.setAttribute("prices",   dto.getPrices());
        req.setAttribute("publishing",dto.getPublishing());
        req.setAttribute("rating",   dto.getRating());
        req.setAttribute("sort",     dto.getSort());

        // 6) JSP 포워드
        req.getRequestDispatcher("main/searchGames.tiles").forward(req, resp);
    }

    /** 안전한 int 파싱 (널이거나 숫자가 아니면 기본값 반환) */
    private int parseInt(String s, int def) {
        try { return Integer.parseInt(s); }
        catch (Exception e) { return def; }
    }

    /** null → 빈 문자열 변환 유틸 */
    private String nullToEmpty(String s) {
        return (s == null) ? "" : s.trim();
    }
}
