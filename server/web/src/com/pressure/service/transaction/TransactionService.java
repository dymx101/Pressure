package com.pressure.service.transaction;

import com.pressure.exception.TransactionException;
import com.pressure.meta.Profile;

public interface TransactionService {
	/**
	 * 插入用户信息从账号注册
	 * 
	 * @param userName
	 * @return
	 * @throws TransactionException
	 */
	public Profile insertProfileFromAccount(String userName)
			throws TransactionException;

	/**
	 * 插入用户信息从第三方
	 * 
	 * @return
	 * @throws TransactionException
	 */
	public Profile insertProfileFromSource() throws TransactionException;
}
