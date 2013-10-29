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
	 * 用于调用access_token，接口获取授权后的access token
	 */
	private String access_token;

	/**
	 * access_token的生命周期，单位是秒数。
	 */
	private String expires_in;

	/**
	 * 当前授权用户的UID。
	 */
	private String uidString;

	public String getAccess_token() {
		return access_token;
	}

	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}

	public String getExpires_in() {
		return expires_in;
	}

	public void setExpires_in(String expires_in) {
		this.expires_in = expires_in;
	}

	public String getUidString() {
		return uidString;
	}

	public void setUidString(String uidString) {
		this.uidString = uidString;
	}
}
