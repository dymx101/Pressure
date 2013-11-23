package com.pressure.service;

import java.util.List;

import com.pressure.meta.ChatType;
import com.pressure.meta.FrChatGroup;
import com.pressure.meta.FrWantChatType;
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

	/**
	 * 获取chatgroup
	 * 
	 * @param userId1
	 * @param userId2
	 * @return
	 */
	public FrChatGroup getFrChatGroup(long userId1, long userId2);

	/**
	 * 添加想聊类型
	 * 
	 * @param userId
	 * @param age
	 * @param gender
	 * @param type
	 * @return
	 */
	public FrWantChatType addFrWantChatType(long userId, int beginAge,
			int endAge, int gender, int type, int chatType);

	/**
	 * 找神父
	 * 
	 * @param userId
	 * @return
	 */
	public Profile tryToFindFather(long userId, int beginAge, int endAge,
			int gender, long chatType);

	/**
	 * 聊天类型
	 * 
	 * @return
	 */
	public List<ChatType> getAllChatTypes();
}
