package com.pressure.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pressure.exception.TransactionException;
import com.pressure.mapper.SourceAccountMapper;
import com.pressure.meta.Profile;
import com.pressure.meta.SourceAccount;
import com.pressure.service.ProfileService;
import com.pressure.service.SourceAccountService;
import com.pressure.service.transaction.TransactionService;

@Service("sourceAccountService")
public class SourceAccountServiceImpl implements SourceAccountService {

	@Resource
	private SourceAccountMapper sourceAccountMapper;

	@Resource
	private ProfileService profileService;

	@Resource
	private TransactionService transactionService;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.SourceAccountService#sourceAccountLogin(long,
	 * java.lang.String, java.lang.String, int)
	 */
	@Override
	public long sourceAccountLogin(long accessUserId, String accessToken,
			String expiresIn, int sourceType) {
		SourceAccount sourceAccount = sourceAccountMapper
				.getSourceAccountByAccessUserId(accessUserId, sourceType);
		if (sourceAccount != null) {
			return sourceAccount.getUserId();
		}
		Profile profile = null;
		try {
			profile = transactionService.insertProfileFromSource();
		} catch (TransactionException e) {
			e.printStackTrace();
		}
		if (profile != null) {
			sourceAccount = new SourceAccount();
			sourceAccount.setUserId(profile.getUserId());
			sourceAccount.setAccessUserId(accessUserId);
			sourceAccount.setAccessUserName("");
			sourceAccount.setAccessToken(accessToken);
			sourceAccount.setExpiresIn(expiresIn);
			sourceAccount.setSourceType(sourceType);
			if (sourceAccountMapper.addSourceAccount(sourceAccount) > 0) {
				return profile.getUserId();
			}
		}
		return -1;
	}
}
