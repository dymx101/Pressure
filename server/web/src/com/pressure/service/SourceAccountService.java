package com.pressure.service;

/**
 * 
 * @ClassName: SourceAccountService
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-30 上午12:40:52
 */
public interface SourceAccountService {

	/**
	 * 添加资源用户信息
	 * 
	 * @param UserId
	 * @param AccessUserId
	 * @param AccessUserName
	 * @param AccessToken
	 * @param ExpiresIn
	 * @param SourceType
	 * @return
	 */
	public boolean addSourceAccount(long AccessUserId, String AccessToken,
			String ExpiresIn, int SourceType);
}
