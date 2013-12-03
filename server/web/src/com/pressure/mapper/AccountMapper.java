package com.pressure.mapper;

import org.apache.ibatis.annotations.Param;

import com.pressure.meta.Account;

/**
 * 
 * @ClassName: AccountMapper
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-29
 */
public interface AccountMapper {

	/**
	 * 添加账号
	 * 
	 * @param account
	 * @return
	 */
	public int addAccount(Account account);

	/**
	 * 获取账号信息
	 * 
	 * @param userName
	 * @return
	 */
	public Account getAccountByUserName(
			@Param(value = "userName") String userName);

	/**
	 * 删除用户信息
	 * 
	 * @param userId
	 * @return
	 */
	public int deleteAccount(@Param(value = "userId") long userId);

}
