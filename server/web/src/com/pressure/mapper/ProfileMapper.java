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
}
