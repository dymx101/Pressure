package com.pressure.service.impl;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pressure.mapper.AccountMapper;
import com.pressure.service.AccountService;

@Service("accountServiceImpl")
public class AccountServiceImpl implements AccountService {

	@Resource
	private AccountMapper accountMapper;

	@Override
	public boolean addAccount(String UserName, String PassWord) {
		if (accountMapper.addAccount(UserName, PassWord, new Date().getTime()) > 0) {
			return true;
		}
		return false;
	}

}
