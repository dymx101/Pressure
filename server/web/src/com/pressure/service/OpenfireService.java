package com.pressure.service;

import com.pressure.meta.OpenfireUser;

public interface OpenfireService {

	/**
	 * 新建openfire 用户
	 * 
	 * @param openfireUser
	 * @return
	 */
	public boolean createOpenfireUser(OpenfireUser openfireUser);

}
