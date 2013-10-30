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
	public int addAccount(@Param(value = "UserName") String UserName,
			@Param(value = "PassWord") String PassWord,
			@Param(value = "CreateTime") long CreateTime);
}
