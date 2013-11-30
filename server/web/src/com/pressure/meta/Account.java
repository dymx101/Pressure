package com.pressure.meta;

import java.io.Serializable;

/**
 * 
 * @ClassName: Account
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-29
 */
public class Account implements Serializable {
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 2L;
	/**
	 * 
	 */
	private long userId;
	/**
	 * 
	 */
	private String userName;
	/**
	 * 
	 */
	private String passWord;
	/**
	 * 
	 */
	private long createTime;

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassWord() {
		return passWord;
	}

	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}

	public long getCreateTime() {
		return createTime;
	}

	public void setCreateTime(long createTime) {
		this.createTime = createTime;
	}

}
