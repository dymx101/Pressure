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
			return sourceAccount.getUserId();
		}

		long nowTime = new Date().getTime();

		Profile profile = new Profile();
		profile.setUserName("未命名");
		profile.setNickName("未命名");
		profile.setTreeholePassWord("");
		profile.setCreateTime(nowTime);
		profile.setLastUpdateTime(nowTime);
		profile.setAvatorUrl("未添加");
		profile.setXmppUserName("");
		profile.setDomain(ServerConstant.OpenFire_Domain);
		profile.setLevel(Profile.ProfileLevel.User.getValue());

		if (profileService.addProfile(profile)) {
			String accessUserName = "未命名";
			SourceAccount sourceAccount2 = new SourceAccount();
			sourceAccount2.setUserId(profile.getUserId());
			sourceAccount2.setAccessUserId(accessUserId);
			sourceAccount2.setAccessUserName(accessUserName);
			sourceAccount2.setAccessToken(accessToken);
			sourceAccount2.setExpiresIn(expiresIn);
			sourceAccount2.setSourceType(sourceType);
			if (sourceAccountMapper.addSourceAccount(sourceAccount2) > 0)
				return profile.getUserId();
		}
		return -1;
	}
}
