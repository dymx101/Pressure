package com.pressure.mapper;

import org.apache.ibatis.annotations.Param;

import com.pressure.meta.Profile;

/**
 * 
 * @ClassName: ProfileMapper
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-28 01:57:12
 */
public interface ProfileMapper {
	/**
	 * 添加用户信息
	 * 
	 * @param profile
	 * @return
	 */
	public int addProfile(Profile profile);

	/**
	 * 获取用户信息
	 * 
	 * @param userId
	 * @return
	 */
	public Profile getProfileByUserId(@Param(value = "userId") long userId);

	/**
	 * 更新xmpp初始化
	 * 
	 * @param initedXmpp
	 * @return
	 */
	public int updateXmppInit(@Param(value = "initedXmpp") int initedXmpp,
			@Param(value = "userId") long userId);

	/**
	 * 更新xmpp用户名
	 * 
	 * @param xmppUserName
	 * @return
	 */
	public int updateXmppUserName(
			@Param(value = "xmppUserName") String xmppUserName,
			@Param(value = "userId") long userId);

	public int updateTreeholePassWord(@Param(value = "userId") long userId,
			@Param(value = "TreeholePassWord") String treeholePassWord);

	/**
	 * 修改昵称和照片
	 * 
	 * @param userId
	 * @param nickName
	 * @param avatorUrl
	 * @param lastUpdateTime
	 * @return
	 */
	public int updateProfile(@Param(value = "UserId") long userId,
			@Param(value = "NickName") String nickName,
			@Param(value = "AvatorUrl") String avatorUrl,
			@Param(value = "LastUpdateTime") long lastUpdateTime);
}
