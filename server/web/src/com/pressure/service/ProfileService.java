package com.pressure.service;

import com.pressure.exception.UserRegisteredException;
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
	 * 注册用户
	 * 
	 * @param userName
	 * @param passWord
	 * @return
	 */
	public long registerUser(String userName, String passWord)
			throws UserRegisteredException;

	/**
	 * 获取用户信息
	 * 
	 * @param userName
	 * @param passWord
	 * @return
	 */
	public Profile getProfileByUserNamePassWord(String userName, String passWord);

	/**
	 * 新建用户
	 * 
	 * @param userName
	 * @return
	 */
	public Profile createProfile(String userName);

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
	 * 获得profile
	 * 
	 * @param xmppUserName
	 * @return
	 */
	public Profile getProfileByXmppUserName(String xmppUserName);

	/**
	 * 创建用户
	 * 
	 * @param profile
	 * @return
	 */
	public boolean addProfile(Profile profile);

	/**
	 * 刷新token
	 * 
	 * @param refreshToken
	 * @param userId
	 * @return
	 */
	public Session updateSessionByRefreshToken(String refreshToken, long userId);

	/**
	 * 创建openfire用户
	 * 
	 * @param profile
	 * @return
	 */
	public boolean createOpenfireUser(Profile profile);

	/**
	 * 更改树洞密码
	 * 
	 * @param userId
	 * @param treeholePassWord
	 * @return
	 */
	public boolean updateTreeholePassword(long userId, String treeholePassWord);

	/**
	 * 更新昵称和照片
	 * 
	 * @param userId
	 * @param nickName
	 * @param avatorUrl
	 * @return
	 */
	public boolean updateProfile(long userId, String nickName,
			String avatorUrl, int gender, String city, int age);

}
