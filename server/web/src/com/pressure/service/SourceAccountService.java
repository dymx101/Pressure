package com.pressure.service;

/**
 * 
 * @ClassName: SourceAccountService
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-30 锟斤拷锟斤拷12:40:52
 */
public interface SourceAccountService {

	/**
	 * 第三方登录
	 * 
	 * @param UserId
	 * @param AccessUserId
	 * @param AccessUserName
	 * @param AccessToken
	 * @param ExpiresIn
	 * @param SourceType
	 * @return
	 */
	public long sourceAccountLogin(long accessUserId, String accessToken,
			String expiresIn, int sourceType);
}
