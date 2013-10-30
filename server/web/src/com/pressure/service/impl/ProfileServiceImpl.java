package com.pressure.service.impl;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pressure.mapper.ProfileMapper;
import com.pressure.meta.Profile;
import com.pressure.service.ProfileService;

@Service("profileServiceImpl")
public class ProfileServiceImpl implements ProfileService {

	@Resource
	private ProfileMapper profileMapper;

	@Override
	public boolean addProfile(String UserName, String NickName, String AvatorUrl) {
		if (profileMapper.addProfile(UserName, NickName, new Date().getTime(),
				new Date().getTime(), AvatorUrl,
				Profile.ProfileLevel.Member.getValue()) > 0) {
			return true;
		}
		return false;
	}
}
