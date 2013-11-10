package com.pressure.meta;

import java.io.Serializable;

public class Session implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4L;

	private long id;

	private long userId;

	private String refreshToken;

	private long CreateTime;

	private long ExpireIn;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getRefreshToken() {
		return refreshToken;
	}

	public void setRefreshToken(String refreshToken) {
		this.refreshToken = refreshToken;
	}

	public long getCreateTime() {
		return CreateTime;
	}

	public void setCreateTime(long createTime) {
		CreateTime = createTime;
	}

	public long getExpireIn() {
		return ExpireIn;
	}

	public void setExpireIn(long expireIn) {
		ExpireIn = expireIn;
	}

}
