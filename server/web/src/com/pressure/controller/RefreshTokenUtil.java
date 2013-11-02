package com.pressure.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pressure.security.MySecurityDelegatingFilter;

/**
 * token处理机制
 * 
 * @author zhengeason
 * 
 */
public class RefreshTokenUtil {

	public static final String TOKENAUTH = "qiqunar_authToken";

	private static final String CODECHAR_STRING = "#####";

	/**
	 * 检查用户是否有效
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public boolean checkUserIsValid(HttpServletRequest request,
			HttpServletResponse response) {

		String accessToken = request.getHeader("refreshToken");
		String userId = request.getHeader("userId");
		MySecurityDelegatingFilter.userMap.get(userId);
		return true;
	}

	/**
	 * 检查token是否有效
	 * 
	 * @param accessToken
	 * @return
	 */
	public boolean checkTokenIsValid(String accessToken) {
		return true;
	}

	/**
	 * 生成新的userToken
	 * 
	 * @param userId
	 * @param createTime
	 * @return
	 */
	public static String genearteNewToken(Long userId, long createTime)
			throws Exception {
		// String encodeString = String.valueOf(userId) + CODECHAR_STRING
		// + createTime;
		// DesUtil desUtil = new DesUtil(TOKENAUTH);
		// return desUtil.getEncString(encodeString);
		return null;
	}
}
