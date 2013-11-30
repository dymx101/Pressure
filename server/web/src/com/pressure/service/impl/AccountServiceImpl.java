package com.pressure.service.impl;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pressure.mapper.AccountMapper;
import com.pressure.meta.Account;
import com.pressure.service.AccountService;

@Service("accountService")
public class AccountServiceImpl implements AccountService {

	@Resource
	private AccountMapper accountMapper;

	@Override
	public boolean addAccount(String userName, String passWord) {
		Account account = new Account();
		account.setUserName(userName);
		account.setPassWord(passWord);
		account.setCreateTime(new Date().getTime());
		if (accountMapper.addAccount(account) > 0) {
			return true;
		}
		return false;
	}

}
