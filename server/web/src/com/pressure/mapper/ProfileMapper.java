package com.pressure.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.bouncycastle.jce.provider.JCEBlockCipher.DESCBC;

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
	public int updateProfile(Profile profile);

	/**
	 * 获取用户
	 * 
	 * @param xmppUserName
	 * @return
	 */
	public Profile getProfileByXmppUserName(
			@Param(value = "xmppUserName") String xmppUserName);

	/**
	 * 根据id获取列表
	 * 
	 * @param userIds
	 * @return
	 */
	public List<Profile> getProfilesByUserIdsOrderTime(
			@Param(value = "userIds") List<Long> userIds,
			@Param(value = "beginAge") int beginAge,
			@Param(value = "endAge") int endAge,
			@Param(value = "gender") int gender);

	/**
	 * 增加用户神父数量
	 * 
	 * @param userId
	 * @param count
	 * @return
	 */
	public int incUserFatherCount(@Param(value = "userId") long userId,
			@Param(value = "count") int count);

	/**
	 * 增加用户talker数量
	 * 
	 * @param userId
	 * @param count
	 * @return
	 */
	public int incUserTalkerCount(@Param(value = "userId") long userId,
			@Param(value = "count") int count);

	/**
	 * 减少用户神父数量
	 * 
	 * @param userId
	 * @param count
	 * @return
	 */
	public int descUserFatherCount(@Param(value = "userId") long userId,
			@Param(value = "count") int count);

	/**
	 * 减少用户talker数量
	 * 
	 * @param userId
	 * @param count
	 * @return
	 */
	public int descUserTalkerCount(@Param(value = "userId") long userId,
			@Param(value = "count") int count);
}
