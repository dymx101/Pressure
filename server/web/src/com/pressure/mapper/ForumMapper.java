package com.pressure.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pressure.meta.Forum;

public interface ForumMapper {
	/**
	 * 添加论坛
	 * 
	 * @param forum
	 * @return
	 */
	public int addForum(Forum forum);

	/**
	 * 获取论坛数据
	 * 
	 * @param id
	 * @return
	 */
	public Forum getForumById(@Param(value = "id") long id);

	/**
	 * 获取论坛内容列表
	 * 
	 * @param beginTime
	 * @param limit
	 * @return
	 */
	public List<Forum> getForumListByTime(
			@Param(value = "beginTime") long beginTime,
			@Param(value = "limit") int limit);
}
