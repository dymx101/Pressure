package com.pressure.meta;

import java.io.Serializable;

public class FrChatGroup implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 组id
	 */
	private long groupId;
	/**
	 * 组名称
	 */
	private String groupName;
	/**
	 * 用户1,如果是神父聊天者类型，user1是神父
	 */
	private long user1;
	/**
	 * 用户2,如果是神父聊天者类型，user2是talker
	 */
	private long user2;
	/**
	 * 0表示正常，1表示已结束
	 */
	private int status;
	/**
	 * 神父聊天者类型,0神父聊天者,1普通聊天
	 */
	private int type;

	public static final int FatherTalker = 0;

	public static final int Talker = 0;
	public static final int Father = 1;

	public long getGroupId() {
		return groupId;
	}

	public void setGroupId(long groupId) {
		this.groupId = groupId;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public long getUser1() {
		return user1;
	}

	public void setUser1(long user1) {
		this.user1 = user1;
	}

	public long getUser2() {
		return user2;
	}

	public void setUser2(long user2) {
		this.user2 = user2;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

}
