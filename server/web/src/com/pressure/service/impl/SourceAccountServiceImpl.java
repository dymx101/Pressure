package com.pressure.service.impl;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pressure.mapper.ProfileMapper;
import com.pressure.mapper.SourceAccountMapper;
import com.pressure.meta.Profile;
import com.pressure.meta.SourceAccount;
import com.pressure.service.SourceAccountService;

@Service("sourceAccountServiceImpl")
public class SourceAccountServiceImpl implements SourceAccountService {

	@Resource
	private SourceAccountMapper sourceAccountMapper;

	@Resource
	private ProfileMapper profileMapper;

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
			return sourceAccount.getUserId();
		}

		long CreateTime = new Date().getTime();
		long LastUpdateTime = new Date().getTime();

		Profile profile = new Profile();
		profile.setUserName("未命名");
		profile.setNickName("未命名");
		profile.setCreateTime(CreateTime);
		profile.setLastUpdateTime(LastUpdateTime);
		profile.setAvatorUrl("未添加");
		profile.setLevel(Profile.ProfileLevel.Member.getValue());

		if (profileMapper.addProfile(profile) > 0) {
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
