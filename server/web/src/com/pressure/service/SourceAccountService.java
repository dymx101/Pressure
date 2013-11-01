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
	 * 锟斤拷锟斤拷锟皆达拷没锟斤拷锟较�
	 * 
	 * @param UserId
	 * @param AccessUserId
	 * @param AccessUserName
	 * @param AccessToken
	 * @param ExpiresIn
	 * @param SourceType
	 * @return
	 */
	public boolean sourceAccountLogin(long AccessUserId, String AccessToken,
			String ExpiresIn, int SourceType);
}
