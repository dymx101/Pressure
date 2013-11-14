package com.pressure.service.impl;

import java.util.Date;
import java.util.Random;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pressure.constant.ServerConstant;
import com.pressure.mapper.ProfileMapper;
import com.pressure.mapper.SessionMapper;
import com.pressure.meta.OpenfireUser;
import com.pressure.meta.Profile;
import com.pressure.meta.Session;
import com.pressure.service.OpenfireService;
import com.pressure.service.ProfileService;
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
	 * @see
	 * com.pressure.service.ProfileService#addProfile(com.pressure.meta.Profile)
	 */
	@Override
	public boolean addProfile(Profile profile) {
		if (profileMapper.addProfile(profile) > 0) {
			this.createOpenfireUser(profile);
			return true;
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.pressure.service.ProfileService#createOpenfireUser(com.pressure.meta
	 * .Profile)
	 */
	@Override
	public boolean createOpenfireUser(Profile profile) {
		OpenfireUser openfireUser = new OpenfireUser();
		openfireUser.setUserName(Profile.genXmppUserName(profile.getUserId()));
		openfireUser.setPassWord(openfireUser.getUserName()
				+ ServerConstant.OpenFire_PassWord_Secrect_Key);
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
	public boolean updateProfile(long userId, String nickName, String avatorUrl) {
		long lastUpdateTime = new Date().getTime();
		if (profileMapper.updateProfile(userId, nickName, avatorUrl,
				lastUpdateTime) > 0) {
			return true;
		}
		return false;
	}
}
