package com.eason.web.util;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.log4j.Logger;

/**
 * @author zhengyisheng E-mail:zhengyisheng@gmail.com
 * @version CreateTime：2012-5-23 下午02:00:36 Class Description
 */
public class CookieUtil {
	private static final Logger logger = Logger.getLogger(CookieUtil.class);
	public static final String PARA_LOGIN_COOKIE = "Login_PassPort";

	public static final String USER_COOKIE_STRING = "User_Cookie";

	private static String DEFAULT_DOMAIN = "outsource.qiqunar.com.cn";

	/**
	 * 获取请求对象中指定cookie名的cookie值
	 * 
	 * @param request
	 *            请求对象
	 * @param cookieName
	 *            指定的cookie值
	 * @param defaultValue
	 *            获取的默认值
	 * @return
	 */
	public static String getCookieValue(HttpServletRequest request,
			String cookieName, String defaultValue) {
		Cookie[] cookieList = request.getCookies();
		if (cookieList == null || cookieName == null)
			return defaultValue;

		for (int i = 0; i < cookieList.length; i++) {
			if (cookieList[i].getName().equals(cookieName))
				return cookieList[i].getValue();
		}
		return defaultValue;
	}

	/**
	 * 得到cookie
	 * 
	 * @param request
	 * @param name
	 * @return
	 */
	public static Cookie getCookie(HttpServletRequest request, String name) {
		Cookie[] cookies = request.getCookies();
		if (ArrayUtils.isEmpty(cookies)) {
			return null;
		}
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(name)) {
				return cookie;
			}
		}
		return null;

	}

	/**
	 * 设置指定Cookie的最长有效时间
	 * 
	 * @param request
	 *            请求对象
	 * @param response
	 *            响应对象
	 * @param cookieName
	 *            需要设置的cookie的名字
	 * @param maxAge
	 *            最大有效时间
	 */
	public static void setCookieMaxAge(HttpServletRequest request,
			HttpServletResponse response, String cookieName, int maxAge) {
		Cookie[] cookieList = request.getCookies();

		for (int i = 0; i < cookieList.length; i++) {
			if (cookieList[i].getName().equals(cookieName)) {
				cookieList[i].setMaxAge(maxAge);
				cookieList[i].setPath("/");
				response.addCookie(cookieList[i]);
			}
		}
	}

	/**
	 * 加入一个Cookie值
	 * 
	 * @param response
	 *            响应对象
	 * @param cookieName
	 *            cookie名
	 * @param cookieValue
	 *            cookie值
	 */
	public static void setCookie(HttpServletResponse response,
			String cookieName, String cookieValue) {
		Cookie theCookie = null;
		try {
			theCookie = new Cookie(java.net.URLEncoder.encode(cookieName,
					"UTF-8"), cookieValue);
		} catch (UnsupportedEncodingException e) {
			logger.error("setCookie(HttpServletResponse, String, String)", e);
		}
		if (theCookie != null) {
			theCookie.setPath("/");
			response.addCookie(theCookie);
		}
	}

	/**
	 * 加入一个Cookie值并设定有效时间
	 * 
	 * @param response
	 *            响应对象
	 * @param cookieName
	 *            cookie名
	 * @param cookieValue
	 *            cookie值
	 * @param cookieMaxage
	 *            最大有效时间
	 */
	public static void setCookie(HttpServletResponse response,
			String cookieName, String cookieValue, int cookieMaxage) {
		setCookie(response, cookieName, cookieValue, null, cookieMaxage);
	}

	/**
	 * 加入一个Cookie值并设定有效时间
	 * 
	 * @param response
	 *            响应对象
	 * @param cookieName
	 *            cookie名
	 * @param cookieValue
	 *            cookie值
	 * @param domain
	 *            domain域
	 * @param cookieMaxage
	 *            最大有效时间
	 */
	public static void setCookie(HttpServletResponse response,
			String cookieName, String cookieValue, String domain,
			int cookieMaxage) {
		if (cookieName != null && cookieValue != null) {
			Cookie theCookie = null;
			try {
				theCookie = new Cookie(java.net.URLEncoder.encode(cookieName,
						"UTF-8"), cookieValue);
			} catch (UnsupportedEncodingException e) {
				logger.error(
						"setCookie(HttpServletResponse, String, String, int)", e); //$NON-NLS-1$
			}
			if (theCookie != null) {
				theCookie.setPath("/");
				if (StringUtils.isNotEmpty(domain))
					theCookie.setDomain(domain);
				else {
					theCookie.setDomain(DEFAULT_DOMAIN);
				}
				theCookie.setMaxAge(cookieMaxage);
				response.addCookie(theCookie);
			}
		}
	}

	public static boolean needAutoLogin(HttpServletRequest request) {
		Cookie cookie = CookieUtil.getCookie(request, PARA_LOGIN_COOKIE);
		if (cookie == null) {
			String cookieValue = CookieUtil.getCookieValue(request,
					PARA_LOGIN_COOKIE, null);
			return StringUtils.isNotBlank(cookieValue);
		}
		return false;
	}

	/**
	 * 删除cookie
	 * 
	 * @param request
	 * @param name
	 * @return
	 */
	public static boolean removeCookie(HttpServletRequest request, String name) {
		Cookie[] cookies = request.getCookies();
		if (ArrayUtils.isEmpty(cookies)) {
			return true;
		}
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(name)) {
				cookie.setMaxAge(0);
				return true;
			}
		}
		return false;
	}
}
