package com.pressure.meta;

import java.io.Serializable;

/**
 * 
 * @ClassName: Profile
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-28 ����02:37:29
 */
public class Profile implements Serializable {
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * �˻�ID
	 */
	private long UserId;
	/**
	 * �˻���
	 */
	private String UserName;
	/**
	 * ����
	 */
	private String name;
	/**
	 * �˻�����
	 */
	private String Password;
	/**
	 * ����ʱ��
	 */
	private long CreateTime;

	public long getUserId() {
		return UserId;
	}

	public void setUserId(long userId) {
		UserId = userId;
	}

	public String getUserName() {
		return UserName;
	}

	public void setUserName(String UserName) {
		this.UserName = UserName;
	}

	public String getPassword() {
		return Password;
	}

	public void setPassword(String password) {
		Password = password;
	}

	public long getCreateTime() {
		return CreateTime;
	}

	public void setCreateTime(long createTime) {
		CreateTime = createTime;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
