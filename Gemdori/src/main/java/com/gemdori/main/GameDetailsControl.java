package com.gemdori.main;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringEscapeUtils;

import com.gemdori.common.Control;
import com.gemdori.main.service.GameService;
import com.gemdori.main.service.GameServiceImpl;
import com.gemdori.main.vo.GameVO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class GameDetailsControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // TODO Auto-generated method stub
        String gameCode = req.getParameter("gameCode");

        GameService service = new GameServiceImpl();
        GameVO game = service.getGameByCode(gameCode);
        
        // Json 객체로 담긴 이미지 리스트를, Java 객체의 이미지 리스트로 변환
        String descImagesJson = game.getDescImages(); 
        
        Gson gson = new GsonBuilder().create();
        List<String> descImagesList = Arrays.asList(gson.fromJson(descImagesJson, String[].class));
        
        game.setImageList(descImagesList);
        
        System.out.println(game);

        // 최소사양
        String requirements = game.getGameSysReq();
        requirements = replace(requirements);
        game.setGameSysReq(requirements);


        // 권장사양
        requirements = game.getGameSysReqR();
        requirements = replace(requirements);
        game.setGameSysReqR(requirements);

        if (requirements.equals("\"\"")) {
            game.setGameSysReqR("");
        }
        else {
            game.setGameSysReqR(requirements);
        }

        req.setAttribute("game", game);
        req.getRequestDispatcher("main/gameDetails.tiles").forward(req, resp);
    }

    private String replace(String raw) {
        // 1. 앞뒤 큰따옴표 제거
        if (raw.startsWith("\"") && raw.endsWith("\"")) {
            raw = raw.substring(1, raw.length() - 1);
        }

        // 2. 유니코드 디코딩
        String decoded = StringEscapeUtils.unescapeJava(raw);

        // 3. 쓸데없는 <strong>최소:</strong> 등 제거
        decoded = decoded.replaceAll("(?i)<strong>\\s*(최소|권장)\\s*:\\s*</strong>", "");
        return decoded;
    }
}
