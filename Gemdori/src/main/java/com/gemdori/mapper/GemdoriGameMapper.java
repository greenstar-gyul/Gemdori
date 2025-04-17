package com.gemdori.mapper;

import java.util.List;
import com.gemdori.vo.GemdoriGameVO;

public interface GemdoriGameMapper {
    List<GemdoriGameVO> selectAllGames();
}