package com.gemdori.community.mapper;

import java.util.List;
import com.gemdori.community.vo.ReplyVO;

public interface ReplyMapper {
    void insertReply(ReplyVO reply);
    List<ReplyVO> selectRepliesByTopicCode(String topicCode);
}
