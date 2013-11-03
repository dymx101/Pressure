package com.pressure.meta;

public class OpenfireUser {
	/**
	 * openfire用户名
	 */
	private String userName;
	/**
	 * openfire密码
	 */
	private String passWord;
	/**
	 * 昵称
	 */
	private String name;

	/**
	 * email
	 */
	private String email;

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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
