package com.pressure.service.impl;

import javax.annotation.Resource;

import com.pressure.mapper.AccountMapper;
import com.pressure.service.AccountService;

/**
 * 
 * @ClassName: AccountServiceImple
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-29 ÏÂÎç06:46:34
 */
public class AccountServiceImple implements AccountService {

	@Resource
	private AccountMapper accountMapper;

	@Override
	public boolean setAccount(String access_token, String expires_in, String uid) {
		if (accountMapper.setAccount(access_token, expires_in, uid) > 0) {
			return true;
		}
		return false;
	}
}
