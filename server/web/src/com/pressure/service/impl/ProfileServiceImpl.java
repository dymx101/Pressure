package com.pressure.service.impl;

import java.util.Date;
import java.util.Random;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pressure.exception.TransactionException;
import com.pressure.exception.UserRegisteredException;
import com.pressure.mapper.AccountMapper;
import com.pressure.mapper.ProfileMapper;
import com.pressure.mapper.SessionMapper;
import com.pressure.meta.Account;
import com.pressure.meta.Profile;
import com.pressure.meta.Session;
import com.pressure.service.OpenfireService;
import com.pressure.service.ProfileService;
import com.pressure.service.transaction.TransactionService;
import com.pressure.util.MD5Util;
import com.pressure.util.TimeUtil;

@Service("profileService")
public class ProfileServiceImpl implements ProfileService {

	@Resource
	private ProfileMapper profileMapper;

	@Resource
	private SessionMapper sessionMapper;

	@Resource
	private OpenfireService openfireService;

	@Resource
	private AccountMapper accountMapper;

	@Resource
	private TransactionService transactionService;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.pressure.service.ProfileService#getSessionByRefreshToken(java.lang
	 * .String)
	 */
	@Override
	public Session getSessionByRefreshToken(String refreshToken) {
		return sessionMapper.getSessionByRefreshToken(refreshToken);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.ProfileService#createSessionByUserId(long)
	 */
	@Override
	public Session createSessionByUserId(long userId) {

		Session session = new Session();
		session.setUserId(userId);
		this.createSession(session, userId);

		if (sessionMapper.addSession(session) > 0) {
			return session;
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.ProfileService#getProfileByUserId(long)
	 */
	@Override
	public Profile getProfileByUserId(long userId) {

		return profileMapper.getProfileByUserId(userId);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.pressure.service.ProfileService#updateSessionByRefreshToken(java.
	 * lang.String, long)
	 */
	@Override
	public Session updateSessionByRefreshToken(String refreshToken, long userId) {
		// 更新token要同步去做
		Session session = sessionMapper.getSessionByRefreshToken(refreshToken);
		this.createSession(session, userId);
		if (sessionMapper.updateSession(session) > 0) {
			return session;
		}
		return null;
	}

	/**
	 * 创建session
	 * 
	 * @param session
	 */
	private void createSession(Session session, long userId) {
		long nowTime = new Date().getTime();
		session.setCreateTime(nowTime);
		// 30天失效
		long exprieIn = TimeUtil.DAY_TIME * 30;
		session.setExpireIn(exprieIn);
		Random random = new Random(100000);
		String originToken = userId + "_" + random.nextLong() + "_"
				+ new Date().getTime();
		String refreshToken = MD5Util.getMD5(originToken.getBytes());
		session.setRefreshToken(refreshToken);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.ProfileService#updateTreeholePassword(long,
	 * java.lang.String)
	 */
	@Override
	public boolean updateTreeholePassword(long userId, String treeholePassWord) {
		if (profileMapper.updateTreeholePassWord(userId, treeholePassWord) > 0) {
			return true;
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.ProfileService#updateProfile(long,
	 * java.lang.String, java.lang.String)
	 */
	@Override
	public boolean updateProfile(long userId, String nickName,
			String avatorUrl, int gender, String city, int age) {
		Profile profile = profileMapper.getProfileByUserId(userId);
		if (profile == null) {
			return false;
		}
		long lastUpdateTime = new Date().getTime();
		profile.setLastUpdateTime(lastUpdateTime);
		profile.setNickName(nickName);
		profile.setAvatorUrl(avatorUrl);
		profile.setGender(gender);
		profile.setCity(city);
		profile.setAge(age);
		if (profileMapper.updateProfile(profile) > 0) {
			return true;
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.pressure.service.ProfileService#getProfileByXmppUserName(java.lang
	 * .String)
	 */
	@Override
	public Profile getProfileByXmppUserName(String xmppUserName) {
		return profileMapper.getProfileByXmppUserName(xmppUserName);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.ProfileService#registerUser(java.lang.String,
	 * java.lang.String)
	 */
	@Override
	public long registerUser(String userName, String passWord)
			throws UserRegisteredException {
		Account account = accountMapper.getAccountByUserName(userName);
		if (account != null) {
			throw new UserRegisteredException();
		}
		Profile profile = null;
		try {
			profile = transactionService.insertProfileFromAccount(userName);
		} catch (TransactionException e) {
			e.printStackTrace();
		}
		if (profile != null) {
			account = new Account();
			account.setCreateTime(new Date().getTime());
			account.setUserName(userName);
			account.setPassWord(passWord);
			account.setUserId(profile.getUserId());
			if (accountMapper.addAccount(account) > 0) {
				return profile.getUserId();
			}
		}
		return -1;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.pressure.service.ProfileService#getProfileByUserNamePassWord(java
	 * .lang.String, java.lang.String)
	 */
	@Override
	public Profile getProfileByUserNamePassWord(String userName, String passWord) {
		Account account = accountMapper.getAccountByUserName(userName);
		if (account != null && account.getPassWord() == passWord) {
			Profile profile = profileMapper.getProfileByUserId(account
					.getUserId());
			return profile;
		}
		return null;
	}

}
