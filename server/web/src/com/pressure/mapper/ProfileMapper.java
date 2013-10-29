package com.pressure.mapper;

import org.apache.ibatis.annotations.Param;

/**
 * 
 * @ClassName: ProfileMapper
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-28 обнГ01:57:12
 */
public interface ProfileMapper {
	public int addProfile(@Param(value = "userName") String userName,
			@Param(value = "password") String password,
			@Param(value = "name") String name,
			@Param(value = "createTime") long createTime);
}
