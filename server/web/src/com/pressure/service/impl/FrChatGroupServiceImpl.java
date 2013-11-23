package com.pressure.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pressure.mapper.ChatTypeMapper;
import com.pressure.mapper.FrChatGroupMapper;
import com.pressure.mapper.FrWantChatTypeMapper;
import com.pressure.mapper.ProfileMapper;
import com.pressure.meta.ChatType;
import com.pressure.meta.FrChatGroup;
import com.pressure.meta.FrWantChatType;
import com.pressure.meta.Profile;
import com.pressure.service.FrChatGroupService;
import com.pressure.service.OpenfireService;
import com.pressure.util.ListUtils;

@Service("frChatGroupService")
public class FrChatGroupServiceImpl implements FrChatGroupService {

	@Resource
	private FrChatGroupMapper frChatGroupMapper;

	@Resource
	private FrWantChatTypeMapper frWantChatTypeMapper;

	@Resource
	private ProfileMapper profileMapper;

	@Resource
	private OpenfireService openfireService;

	@Resource
	private ChatTypeMapper chatTypeMapper;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.pressure.service.FrChatGroupService#addFrChatGroupService(com.pressure
	 * .meta.Profile, com.pressure.meta.Profile)
	 */
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.FrChatGroupService#addFrWantChatType(long, int,
	 * int, int)
	 */
	@Override
	public FrWantChatType addFrWantChatType(long userId, int beginAge,
			int endAge, int gender, int type, int chatType) {
		FrWantChatType wantChatType = frWantChatTypeMapper.getFrWantChatType(
				userId, type);
		if (wantChatType != null) {
			wantChatType.setBeginAge(beginAge);
			wantChatType.setEndAge(endAge);
			wantChatType.setGender(gender);
			if (frWantChatTypeMapper.updateFrWantChatType(wantChatType) > 0) {
				return wantChatType;
			}
		}
		wantChatType = new FrWantChatType();
		wantChatType.setBeginAge(beginAge);
		wantChatType.setEndAge(endAge);
		wantChatType.setGender(gender);
		wantChatType.setUserId(userId);
		wantChatType.setType(type);
		wantChatType.setCreateTime(new Date().getTime());
		wantChatType.setStatus(0);
		wantChatType.setChatType(chatType);
		if (frWantChatTypeMapper.addFrWantChatType(wantChatType) > 0) {
			return wantChatType;
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.FrChatGroupService#tryToFindFather(long)
	 */
	@Override
	public Profile tryToFindFather(long userId, int beginAge, int endAge,
			int gender, long chatType) {
		// Profile userProfile = profileMapper.getProfileByUserId(userId);
		Profile profile = this.totallyMatch(userId, beginAge, endAge, gender,
				chatType);
		if (profile != null) {
			return profile;
		}
		profile = this.firstMatch(userId, gender, chatType);
		if (profile != null) {
			return profile;
		}
		profile = this.secondMatch(userId, gender);
		if (profile != null) {
			return profile;
		}
		return null;
	}

	/**
	 * 一级匹配,保证性别，聊天类型匹配并且在线
	 * 
	 * @param userId
	 * @param gender
	 * @param chatType
	 * @return
	 */
	private Profile firstMatch(long userId, int gender, long chatType) {
		// 完全匹配
		List<FrWantChatType> typeList = frWantChatTypeMapper
				.getFrWantChatTypesByType(FrWantChatType.Father, chatType);
		if (!ListUtils.isEmptyList(typeList)) {
			List<Profile> profileList = this.usersByChatType(typeList,
					Profile.ONLINE, 0, Integer.MAX_VALUE, gender);
			// 如果有用户在线
			if (!ListUtils.isEmptyList(profileList)) {
				return this.userFromProfiles(userId, profileList);
			}
		}
		return null;
	}

	/**
	 * 二级匹配,保证性别
	 * 
	 * @param gender
	 * @return
	 */
	private Profile secondMatch(long userId, int gender) {
		List<FrWantChatType> typeList = frWantChatTypeMapper
				.getFrWantChatTypesByType(FrWantChatType.Father, -1);
		if (!ListUtils.isEmptyList(typeList)) {
			List<Profile> profileList = this.usersByChatType(typeList,
					Profile.ONLINE, 0, Integer.MAX_VALUE, gender);
			// 如果有用户在线
			if (!ListUtils.isEmptyList(profileList)) {
				return this.userFromProfiles(userId, profileList);
			} else {
				profileList = this.usersByChatType(typeList, Profile.OFFLINE,
						0, Integer.MAX_VALUE, -1);
				return this.userFromProfiles(userId, profileList);
			}
		}
		return null;
	}

	/**
	 * 完美匹配,保证年龄，性别，聊天类型匹配并且在线
	 * 
	 * @param userId
	 * @param age
	 * @param gender
	 * @param chatType
	 * @return
	 */
	private Profile totallyMatch(long userId, int beginAge, int endAge,
			int gender, long chatType) {
		// 完全匹配
		List<FrWantChatType> typeList = frWantChatTypeMapper
				.getFrWantChatTypesByType(FrWantChatType.Father, chatType);
		if (!ListUtils.isEmptyList(typeList)) {
			List<Profile> profileList = this.usersByChatType(typeList,
					Profile.ONLINE, beginAge, endAge, gender);
			// 如果有用户在线
			if (!ListUtils.isEmptyList(profileList)) {
				return this.userFromProfiles(userId, profileList);
			}
		}
		return null;
	}

	/**
	 * 获取在线用户
	 * 
	 * @param typeList
	 * @return
	 */
	private List<Profile> usersByChatType(List<FrWantChatType> typeList,
			int Online, int beginAge, int endAge, int gender) {
		List<Long> userIds = new ArrayList<Long>();
		for (FrWantChatType chatType2 : typeList) {
			userIds.add(chatType2.getUserId());
		}
		List<Profile> profileList = profileMapper
				.getProfilesByUserIdsOrderTime(userIds, beginAge, endAge,
						gender);

		// 这里要处理，而且需要考虑大数据的问题
		// 获取用户在线状态
		openfireService.getUsersOnlineStatus(profileList);
		return profileList;
	}

	/**
	 * 将自己排除在外，还要将正在聊天的用户排除在外
	 * 
	 * @param userId
	 * @param profileList
	 * @return
	 */
	private Profile userFromProfiles(long userId, List<Profile> profileList) {
		for (Profile profile : profileList) {
			if (userId == profile.getUserId()) {
				continue;
			}
			return profile;
		}
		return null;
		// 还要将正在聊天的用户排除在外
	}

	@Override
	public List<ChatType> getAllChatTypes() {
		return chatTypeMapper.getAllChatTypes();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.FrChatGroupService#getFrChatGroup(long, long)
	 */
	@Override
	public FrChatGroup getFrChatGroup(long userId1, long userId2) {

		return frChatGroupMapper.getFrChatGroup(userId1, userId2, 0);
	}
}
