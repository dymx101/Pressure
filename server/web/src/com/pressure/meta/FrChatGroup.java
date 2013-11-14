package com.pressure.meta;

import java.io.Serializable;

public class FrChatGroup implements Serializable{
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
	 * 用户1
	 */
	private long user1;
	/**
	 * 用户2
	 */
	private long user2;
	/**
	 * 0表示正常，1表示已结束
	 */
	private int status;

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

}
