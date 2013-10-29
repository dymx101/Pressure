package com.pressure.service;

/**
 * 
 * @ClassName: AccountService
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-29 下午06:35:43
 */
public interface AccountService {

	/**
	 * 添加Account信息
	 * 
	 * @param access_token
	 * @param expires_in
	 * @param uid
	 * @return
	 */
	public boolean setAccount(String access_token, String expires_in, String uid);
}
