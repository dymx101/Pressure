package com.pressure.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pressure.mapper.FrChatGroupMapper;
import com.pressure.meta.FrChatGroup;
import com.pressure.meta.Profile;
import com.pressure.service.FrChatGroupService;

@Service("frChatGroupService")
public class FrChatGroupServiceImpl implements FrChatGroupService {

	@Resource
	private FrChatGroupMapper frChatGroupMapper;

	@Override
	public FrChatGroup addFrChatGroupService(Profile user1, Profile user2) {
		FrChatGroup frChatGroup = new FrChatGroup();
		frChatGroup.setUser1(user1.getUserId());
		frChatGroup.setUser2(user2.getUserId());
		frChatGroup.setStatus(0);
		frChatGroup.setGroupName(user1.getXmppUserName() + user1.getDomain()
				+ "_" + user2.getXmppUserName() + user2.getDomain());
		if (frChatGroupMapper.addFrChatGroup(frChatGroup) > 0) {
			return frChatGroup;
		}
		return null;
	}

}
