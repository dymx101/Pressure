package com.pressure.service;

/**
 * 
 * @ClassName: ProfileService
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-30 ионГ12:50:47
 */
public interface ProfileService {

	/**
	 * 
	 * @param UserName
	 * @param NickName
	 * @param AvatorUrl
	 * @return
	 */
	public boolean addProfile(String UserName, String NickName, String AvatorUrl);
}
