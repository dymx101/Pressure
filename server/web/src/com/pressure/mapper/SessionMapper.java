package com.pressure.mapper;

import org.apache.ibatis.annotations.Param;

import com.pressure.meta.Session;

public interface SessionMapper {
	/**
	 * 添加session
	 * 
	 * @param session
	 * @return
	 */
	public int addSession(Session session);

	/**
	 * 根据token取数据
	 * 
	 * @param refreshToken
	 * @return
	 */
	public Session getSessionByRefreshToken(
			@Param(value = "refreshToken") String refreshToken);

	/**
	 * 更新session
	 * 
	 * @param session
	 * @return
	 */
	public int updateSession(Session session);
}
