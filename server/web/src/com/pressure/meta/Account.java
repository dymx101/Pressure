package com.pressure.meta;

import java.io.Serializable;

/**
 * 
 * @ClassName: Account
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-29 下午06:04:37
 */
public class Account implements Serializable {
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 2L;
	/**
	 * 用户ID
	 */
	private long UserId;
	/**
	 * 用户名
	 */
	private String UserName;
	/**
	 * 密码
	 */
	private String PassWord;
	/**
	 * 创建时间
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

	public void setUserName(String userName) {
		UserName = userName;
	}

	public String getPassWord() {
		return PassWord;
	}

	public void setPassWord(String passWord) {
		PassWord = passWord;
	}

	public long getCreateTime() {
		return CreateTime;
	}

	public void setCreateTime(long createTime) {
		CreateTime = createTime;
	}
}
