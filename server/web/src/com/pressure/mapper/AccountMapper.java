package com.pressure.mapper;

import org.apache.ibatis.annotations.Param;

/**
 * 
 * @ClassName: AccountMapper
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-29 обнГ06:48:43
 */
public interface AccountMapper {
	public int setAccount(@Param(value = "access_token") String access_token,
			@Param(value = "expires_in") String expires_in,
			@Param(value = "uid") String uid);
}
