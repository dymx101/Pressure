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
	public int addProfile(@Param(value = "UserName") String UserName,
			@Param(value = "NickName") String NickName,
			@Param(value = "CreateTime") long CreateTime,
			@Param(value = "LastUpdateTime") long LastUpdateTime,
			@Param(value = "AvatorUrl") String AvatorUrl,
			@Param(value = "level") int level);
}
