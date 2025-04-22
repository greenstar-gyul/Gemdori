package com.gemdori.community.mapper;

import java.util.List;

import com.gemdori.community.vo.TopicVO;

public interface TopicMapper {
	void insertTopic(TopicVO post);
	List<TopicVO> selectTopicList();
	TopicVO selectTopic(String topicCode);


}
