package com.pressure.service.impl;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pressure.mapper.ProfileMapper;
import com.pressure.service.ProfileService;

/**
 * 
 * @ClassName: ProfileServiceImpl
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-28 ÏÂÎç01:58:46
 */
@Service("profileService")
public class ProfileServiceImpl implements ProfileService {

	@Resource
	private ProfileMapper profileMapper;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.ProfileService#addProfile(java.lang.String,
	 * java.lang.String, java.lang.String)
	 */
	@Override
	public boolean addProfile(String userName, String password, String name) {
		if (userName == null || password == null || name == null) {
			return false;
		}
		long createTime = new Date().getTime();
		return profileMapper.addProfile(userName, password, name, createTime) > 0;
	}
}
