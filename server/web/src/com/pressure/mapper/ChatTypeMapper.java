package com.pressure.mapper;

import java.util.List;

import com.pressure.meta.ChatType;

public interface ChatTypeMapper {

	/**
	 * 添加聊天类型
	 * 
	 * @param chatType
	 * @return
	 */
	public int addChatType(ChatType chatType);

	/**
	 * 
	 * @return
	 */
	public List<ChatType> getAllChatTypes();
}
