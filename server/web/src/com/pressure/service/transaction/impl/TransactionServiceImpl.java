package com.pressure.service.transaction.impl;

import java.util.Date;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.pressure.constant.ServerConstant;
import com.pressure.exception.TransactionException;
import com.pressure.mapper.ProfileMapper;
import com.pressure.meta.OpenfireUser;
import com.pressure.meta.Profile;
import com.pressure.service.OpenfireService;
import com.pressure.service.transaction.TransactionService;

@Service("transactionService")
public class TransactionServiceImpl implements TransactionService {

	@Resource
	private ProfileMapper profileMapper;

	@Resource
	private OpenfireService openfireService;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.pressure.service.transaction.TransactionService#insertProfile(java
	 * .lang.String)
	 */
	public Profile insertProfileFromAccount(String userName)
			throws TransactionException {

		long nowTime = new Date().getTime();
		Profile profile = new Profile();
		if (!StringUtils.isEmpty(userName)) {
			profile.setUserName(userName);
		} else {
			throw new TransactionException();
		}
		profile.setNickName("");
		profile.setTreeholePassWord("");
		profile.setCreateTime(nowTime);
		profile.setLastUpdateTime(nowTime);
		// 注册用户的时候，性别是-1
		profile.setGender(-1);
		profile.setAvatorUrl("");
		profile.setXmppUserName("");
		profile.setDomain(ServerConstant.OpenFire_Domain);
		profile.setLevel(Profile.ProfileLevel.User.getValue());
		profile.setMaxFatherCount(3);
		profile.setMaxTalkerCount(3);
		if (profileMapper.addProfile(profile) <= 0) {
			throw new TransactionException();
		}
		try {
			this.createOpenfireUser(profile);
		} catch (Exception e) {
			throw new TransactionException();
		}
		return profile;

	}

	/**
	 * 新建openfire用户
	 * 
	 * @param profile
	 * @return
	 * @throws Exception
	 */
	private boolean createOpenfireUser(Profile profile) throws Exception {
		OpenfireUser openfireUser = new OpenfireUser();
		openfireUser.setUserName(Profile.genXmppUserName(profile.getUserId()));
		openfireUser.setPassWord(openfireUser.getUserName()
				+ ServerConstant.OpenFire_PassWord_Secure_Key);
		openfireUser.setName("");
		openfireUser.setEmail("");
		if (openfireService.createOpenfireUser(openfireUser)) {
			profile.setInitedXmpp(1);
			profile.setXmppUserName(openfireUser.getUserName());
			profileMapper.updateXmppInit(profile.getInitedXmpp(),
					profile.getUserId());
			profileMapper.updateXmppUserName(profile.getXmppUserName(),
					profile.getUserId());
			return true;
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.pressure.service.transaction.TransactionService#createProfileFromSource
	 * ()
	 */
	@Override
	public Profile insertProfileFromSource() throws TransactionException {
		long nowTime = new Date().getTime();
		Profile profile = new Profile();
		profile.setUserName("");
		profile.setNickName("");
		profile.setTreeholePassWord("");
		profile.setCreateTime(nowTime);
		profile.setLastUpdateTime(nowTime);
		// 注册用户的时候，性别是-1
		profile.setGender(-1);
		profile.setAvatorUrl("");
		profile.setXmppUserName("");
		profile.setDomain(ServerConstant.OpenFire_Domain);
		profile.setLevel(Profile.ProfileLevel.User.getValue());
		profile.setMaxFatherCount(3);
		profile.setMaxTalkerCount(3);
		if (profileMapper.addProfile(profile) < 0) {
			throw new TransactionException();
		}
		try {
			this.createOpenfireUser(profile);
		} catch (Exception e) {
			throw new TransactionException();
		}
		return profile;
	}
}
