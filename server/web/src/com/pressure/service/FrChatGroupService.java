package com.pressure.service;

import com.pressure.meta.FrChatGroup;
import com.pressure.meta.Profile;

public interface FrChatGroupService {

	/**
	 * 新建一个聊天
	 * 
	 * @param user1
	 * @param user2
	 * @return
	 */
	public FrChatGroup addFrChatGroupService(Profile user1, Profile user2);
}
