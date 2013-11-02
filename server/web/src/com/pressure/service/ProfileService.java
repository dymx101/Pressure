package com.pressure.service;

import com.pressure.meta.Profile;
import com.pressure.meta.Session;

/**
 * 
 * @ClassName: ProfileService
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-30 12:50:47
 */
public interface ProfileService {
	/**
	 * 获取session
	 * 
	 * @param refreshToken
	 * @return
	 */
	public Session getSessionByRefreshToken(String refreshToken);

	/**
	 * 为用户创建api的session
	 * 
	 * @param userId
	 * @return
	 */
	public Session createSessionByUserId(long userId);

	/**
	 * 获取用户信息
	 * 
	 * @param userId
	 * @return
	 */
	public Profile getProfileByUserId(long userId);

	/**
	 * 刷新token
	 * 
	 * @param refreshToken
	 * @param userId
	 * @return
	 */
	public Session updateSessionByRefreshToken(String refreshToken, long userId);
}
