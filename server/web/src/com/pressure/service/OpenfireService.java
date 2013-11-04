package com.pressure.service;

import com.pressure.meta.OpenfireUser;

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

}
