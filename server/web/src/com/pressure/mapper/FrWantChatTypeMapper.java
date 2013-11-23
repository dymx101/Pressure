package com.pressure.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pressure.meta.FrWantChatType;

public interface FrWantChatTypeMapper {

	/**
	 * 添加
	 * 
	 * @param chatType
	 * @return
	 */
	public int addFrWantChatType(FrWantChatType chatType);

	/**
	 * 更新
	 * 
	 * @param chatType
	 * @return
	 */
	public int updateFrWantChatType(FrWantChatType chatType);

	/**
	 * 得到
	 * 
	 * @param userId
	 * @param type
	 * @return
	 */
	public FrWantChatType getFrWantChatType(
			@Param(value = "userId") long userId,
			@Param(value = "type") int type);

	/**
	 * 根据类型取，如果参数不要，就传-1
	 * 
	 * @param type
	 * @return
	 */
	public List<FrWantChatType> getFrWantChatTypesByType(
			@Param(value = "type") int type,
			@Param(value = "chatType") long chatType);

}
