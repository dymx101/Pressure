package com.pressure.service.impl;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pressure.constant.ServerConstant;
import com.pressure.mapper.SourceAccountMapper;
import com.pressure.meta.Profile;
import com.pressure.meta.SourceAccount;
import com.pressure.service.ProfileService;
import com.pressure.service.SourceAccountService;

@Service("sourceAccountService")
public class SourceAccountServiceImpl implements SourceAccountService {

	@Resource
	private SourceAccountMapper sourceAccountMapper;

	@Resource
	private ProfileService profileService;

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
			Profile profile = profileService.getProfileByUserId(sourceAccount
					.getUserId());
			if (profile != null && profile.getInitedXmpp() == 0) {
				profileService.createOpenfireUser(profile);
			}
			return profile.getUserId();
		}

		Profile profile = profileService.createProfile(null);
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
