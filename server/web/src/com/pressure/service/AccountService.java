package com.pressure.service;

/**
 * 
 * @ClassName: AccountService
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-29 ����06:35:43
 */
public interface AccountService {

	/**
	 * ���Account��Ϣ
	 * 
	 * @param access_token
	 * @param expires_in
	 * @param uid
	 * @return
	 */
	public boolean setAccount(String access_token, String expires_in, String uid);
}
