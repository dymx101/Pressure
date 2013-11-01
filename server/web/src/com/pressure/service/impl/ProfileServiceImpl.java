package com.pressure.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pressure.mapper.ProfileMapper;
import com.pressure.service.ProfileService;

@Service("profileServiceImpl")
public class ProfileServiceImpl implements ProfileService {

	@Resource
	private ProfileMapper profileMapper;
}
