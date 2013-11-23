package com.pressure.mapper;

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
}
