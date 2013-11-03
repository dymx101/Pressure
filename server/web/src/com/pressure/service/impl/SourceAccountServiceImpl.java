package com.pressure.service.impl;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pressure.mapper.SourceAccountMapper;
import com.pressure.meta.Profile;
import com.pressure.meta.SourceAccount;
import com.pressure.service.ProfileService;
import com.pressure.service.SourceAccountService;

@Service("sourceAccountServiceImpl")
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
	public long sourceAccountLogin(long AccessUserId, String AccessToken,
			String ExpiresIn, int SourceType) {
		SourceAccount sourceAccount = sourceAccountMapper
				.getSourceAccountByAccessUserId(AccessUserId, SourceType);
		if (sourceAccount != null) {
			Profile profile = profileService.getProfileByUserId(sourceAccount
					.getUserId());
			if (profile.getInitedXmpp() == 0) {
				profileService.createOpenfireUser(profile);
			}
			return sourceAccount.getUserId();
		}

		long nowTime = new Date().getTime();
		
		Profile profile = new Profile();
		profile.setUserName("未命名");
		profile.setNickName("未命名");
		profile.setCreateTime(nowTime);
		profile.setLastUpdateTime(nowTime);
		profile.setAvatorUrl("未添加");
		profile.setLevel(Profile.ProfileLevel.Member.getValue());

		if (profileService.addProfile(profile)) {
			String accessUserName = "未命名";
			SourceAccount sourceAccount2 = new SourceAccount();
			sourceAccount2.setUserId(profile.getUserId());
			sourceAccount2.setAccessUserId(AccessUserId);
			sourceAccount2.setAccessUserName(accessUserName);
			sourceAccount2.setAccessToken(AccessToken);
			sourceAccount2.setExpiresIn(ExpiresIn);
			sourceAccount2.setSourceType(SourceType);
			if (sourceAccountMapper.addSourceAccount(sourceAccount2) > 0)
				return profile.getUserId();
		}
		return -1;
	}
}
