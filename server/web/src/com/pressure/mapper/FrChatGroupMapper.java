package com.pressure.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pressure.meta.FrChatGroup;

public interface FrChatGroupMapper {
	/**
	 * 添加一个新的组
	 * 
	 * @param frChatGroup
	 * @return
	 */
	public int addFrChatGroup(FrChatGroup frChatGroup);

	/**
	 * 获取
	 * 
	 * @param userId1
	 * @param userId2
	 * @param status
	 * @return
	 */
	public FrChatGroup getFrChatGroup(@Param(value = "userId1") long userId1,
			@Param(value = "userId2") long userId2,
			@Param(value = "status") int status);

	/**
	 * 获取自己是神父的聊天组
	 * 
	 * @param userId
	 * @return
	 */
	public List<FrChatGroup> getFrChatGroupsByUserIdIsFather(
			@Param(value = "userId") long userId);

	/**
	 * 返回自己的talker的聊天组
	 * 
	 * @param userId
	 * @return
	 */
	public List<FrChatGroup> getFrChatGroupsByUserIdIsTalker(
			@Param(value = "userId") long userId);
}
