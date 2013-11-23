package com.pressure.meta;

import java.io.Serializable;

public class FrWantChatType implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private long userId;

	private long createTime;

	private int gender;

	private int beginAge;

	private int endAge;
	/**
	 * 0表示当前用户做神父，1表示当前用户做倾诉者
	 */
	private int type;

	private int status;
	/**
	 * 聊天的类型
	 */
	private long chatType;

	public static final int Father = 0;

	public static final int Talker = 1;

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getCreateTime() {
		return createTime;
	}

	public void setCreateTime(long createTime) {
		this.createTime = createTime;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public int getBeginAge() {
		return beginAge;
	}

	public void setBeginAge(int beginAge) {
		this.beginAge = beginAge;
	}

	public int getEndAge() {
		return endAge;
	}

	public void setEndAge(int endAge) {
		this.endAge = endAge;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public long getChatType() {
		return chatType;
	}

	public void setChatType(long chatType) {
		this.chatType = chatType;
	}

}
