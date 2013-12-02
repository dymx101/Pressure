package com.pressure.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pressure.mapper.ChatTypeMapper;
import com.pressure.mapper.ForumMapper;
import com.pressure.mapper.FrChatGroupMapper;
import com.pressure.mapper.FrWantChatTypeMapper;
import com.pressure.mapper.ProfileMapper;
import com.pressure.meta.ChatType;
import com.pressure.meta.Forum;
import com.pressure.meta.FrChatGroup;
import com.pressure.meta.FrWantChatType;
import com.pressure.meta.Profile;
import com.pressure.service.FrChatGroupService;
import com.pressure.service.OpenfireService;
import com.pressure.util.HashMapMaker;
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

	@Resource
	private ForumMapper forumMapper;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.pressure.service.FrChatGroupService#addFrChatGroupService(com.pressure
	 * .meta.Profile, com.pressure.meta.Profile)
	 */
	@Override
	public FrChatGroup addFrChatGroupService(Profile user1, Profile user2,
			int type) {
		FrChatGroup frChatGroup = new FrChatGroup();
		frChatGroup.setUser1(user1.getUserId());
		frChatGroup.setUser2(user2.getUserId());
		frChatGroup.setType(type);
		frChatGroup.setStatus(0);
		frChatGroup.setUpdateTime(new Date().getTime());
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
			wantChatType.setType(type);
			wantChatType.setChatType(chatType);
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
		// 完全匹配
		Profile profile = this.totallyMatch(userId, beginAge, endAge, gender,
				chatType);
		if (profile != null) {
			return profile;
		}
		// 一级匹配,保证性别，聊天类型匹配并且在线
		profile = this.firstMatch(userId, gender, chatType);
		if (profile != null) {
			return profile;
		}
		// 二级匹配,保证性别
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
				.getFrWantChatTypesByType(FrWantChatType.VisitFather, chatType);
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
	 * 二级匹配,保证性别，在线不在线都可以
	 * 
	 * @param gender
	 * @return
	 */
	private Profile secondMatch(long userId, int gender) {
		List<FrWantChatType> typeList = frWantChatTypeMapper
				.getFrWantChatTypesByType(FrWantChatType.VisitFather, -1);
		if (!ListUtils.isEmptyList(typeList)) {
			List<Profile> profileList = this.usersByChatType(typeList,
					Profile.ONLINE, 0, Integer.MAX_VALUE, gender);
			// 如果有用户在线
			if (!ListUtils.isEmptyList(profileList)) {
				return this.userFromProfiles(userId, profileList);
			} else {
				// 如果用户不在线
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
				.getFrWantChatTypesByType(FrWantChatType.VisitFather, chatType);
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
		List<Profile> profileList = null;
		if (!ListUtils.isEmptyList(userIds)) {
			profileList = profileMapper.getProfilesByUserIdsOrderTime(userIds,
					beginAge, endAge, gender);
		}

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
		List<FrChatGroup> chatGroups = frChatGroupMapper
				.getFrChatGroupsByUserIdIsTalker(userId, -1, 0);
		Map<Long, FrChatGroup> chatGroupMap = HashMapMaker.listToMap(
				chatGroups, "getUser1", FrChatGroup.class);
		for (Profile profile : profileList) {
			if (userId == profile.getUserId()) {
				continue;
			}
			if (profile.getNowTalkerCount() >= profile.getMaxTalkerCount()) {
				continue;
			}
			// 判断这个用户的神父列表中是否已经存在用户
			FrChatGroup chatGroup = chatGroupMap.get(profile.getUserId());
			if (chatGroup != null) {
				continue;
			}
			return profile;
		}
		return null;
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.FrChatGroupService#matchTalkerFromForum(long,
	 * long)
	 */
	@Override
	public FrChatGroup matchTalkerFromForum(long userId, Forum forum) {
		Profile myProfile = profileMapper.getProfileByUserId(userId);
		Profile profile = profileMapper.getProfileByUserId(forum.getUserId());
		if (profile.getUserId() == userId) {
			return null;
		}
		boolean succ = openfireService.addRoster(profile.getXmppUserName(),
				myProfile.getJid(), "", 3, "");
		if (!succ) {
			return null;
		}
		openfireService.sendFatherFindTalker(myProfile.getJid(),
				profile.getJid());
		FrChatGroup chatGroup = this.addFrChatGroupService(myProfile, profile,
				FrChatGroup.FatherTalker);
		if (chatGroup != null) {
			return chatGroup;
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.FrChatGroupService#getChatGroupsByType(long,
	 * int)
	 */
	@Override
	public List<FrChatGroup> getChatGroupsByType(long userId, int type,
			int limit, long updateTime) {
		// type 指获取的列表的用户是神父
		List<FrChatGroup> frChatGroups = null;
		if (type == FrWantChatType.VisitFather) {
			frChatGroups = frChatGroupMapper.getFrChatGroupsByUserIdIsTalker(
					userId, limit, updateTime);
		}
		if (type == FrWantChatType.VisitTalker) {
			frChatGroups = frChatGroupMapper.getFrChatGroupsByUserIdIsFather(
					userId, limit, updateTime);
		}
		List<Long> userIds = new ArrayList<Long>(frChatGroups.size());
		for (FrChatGroup frChatGroup : frChatGroups) {
			if (type == FrWantChatType.VisitFather) {
				userIds.add(frChatGroup.getUser1());
			} else {
				userIds.add(frChatGroup.getUser2());
			}
		}

		List<Profile> profileList = null;
		if (!ListUtils.isEmptyList(userIds)) {
			profileList = profileMapper.getProfilesByUserIdsOrderTime(userIds,
					-1, Integer.MAX_VALUE, -1);
		}

		Map<Long, Profile> profileMap = HashMapMaker.listToMap(profileList,
				"getUserId", Profile.class);
		for (FrChatGroup frChatGroup : frChatGroups) {
			if (type == FrWantChatType.VisitFather) {
				Profile profile = profileMap.get(frChatGroup.getUser1());
				if (profile != null) {
					frChatGroup.setFatherProfile(profile);
				}
			} else {
				Profile profile = profileMap.get(frChatGroup.getUser1());
				if (profile != null) {
					frChatGroup.setTalkerProfile(profile);
				}
			}
		}
		return frChatGroups;
	}
}
