package com.pressure.service;

import java.util.List;

import com.pressure.meta.OpenfireUser;
import com.pressure.meta.Profile;

public interface OpenfireService {

	/**
	 * 新建openfire 用户
	 * 
	 * @param openfireUser
	 * @return
	 */
	public boolean createOpenfireUser(OpenfireUser openfireUser);

	/**
	 * 添加好友
	 * 
	 * @param fromUserName
	 * @param toJid
	 * @param name
	 * @param sub
	 * @param groupName
	 * @return
	 */
	public boolean addRoster(String fromUserName, String toJid, String name,
			int sub, String groupName);

	/**
	 * 获取用户在线状态
	 * 
	 * @param profileList
	 */
	public void getUsersOnlineStatus(List<Profile> profileList);

	/**
	 * talker找到father 的时候，给father发一个消息
	 * 
	 * @param fromJid
	 * @param toJid
	 */
	public void sendTalkerFindFather(String fromJid, String toJid);

	/**
	 * father找到talker的时候，给talker发一个消息
	 * 
	 * @param fromJid
	 * @param toJid
	 */
	public void sendFatherFindTalker(String fromJid, String toJid);
}
