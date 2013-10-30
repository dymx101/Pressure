package com.pressure.service.impl;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pressure.mapper.SourceAccountMapper;
import com.pressure.service.SourceAccountService;

@Service("sourceAccountServiceImpl")
public class SourceAccountServiceImpl implements SourceAccountService {

	@Resource
	private SourceAccountMapper sourceAccountMapper;

	@Override
	public boolean addSourceAccount(long AccessUserId, String AccessToken,
			String ExpiresIn, int SourceType) {
		if (sourceAccountMapper.getSourceAccountByUserId(AccessUserId,
				SourceType) != null) {
			return false;
		}

		long UserId = 0;
		String AccessUserName = "";

		if (sourceAccountMapper.addSourceAccount(UserId, AccessUserId,
				AccessUserName, AccessToken, ExpiresIn, SourceType,
				new Date().getTime()) > 0) {
			return true;
		}
		return false;
	}
}
