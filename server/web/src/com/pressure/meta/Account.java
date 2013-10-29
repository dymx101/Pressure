package com.pressure.meta;

import java.io.Serializable;

/**
 * 
 * @ClassName: Account
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-29 ����06:04:37
 */
public class Account implements Serializable {
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 2L;

	/**
	 * ���ڵ���access_token���ӿڻ�ȡ��Ȩ���access token
	 */
	private String access_token;

	/**
	 * access_token���������ڣ���λ��������
	 */
	private String expires_in;

	/**
	 * ��ǰ��Ȩ�û���UID��
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
