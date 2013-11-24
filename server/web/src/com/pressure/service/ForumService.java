package com.pressure.service;

import java.util.List;

import com.pressure.meta.Audio;
import com.pressure.meta.Forum;
import com.pressure.meta.Picture;

public interface ForumService {

	/**
	 * 添加论坛
	 * 
	 * @param forum
	 * @return
	 */
	public Forum addForum(String text, Audio audio, Picture picture,
			long userId, int chatType);

	/**
	 * 获取论坛列表
	 * 
	 * @param beginTime
	 * @param limit
	 * @return
	 */
	public List<Forum> getForumsByTime(long beginTime, int limit);

	/**
	 * 获取论坛数据
	 * 
	 * @param id
	 * @return
	 */
	public Forum getForumById(long id);
}
