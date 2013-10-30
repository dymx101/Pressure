package com.pressure.security;

import java.io.IOException;
import java.util.Date;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ArrayUtils;
import org.apache.log4j.Logger;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.PathMatcher;

import com.pressure.meta.OnlineUser;

public class MySecurityDelegatingFilter extends HttpServlet implements Filter {

	private static final String[] noAuthURIConfig = { "/**/apiPressurePub.do*" };

	private static final String[] noAdminURIConfig = { "/**/apiPressure.do*" };
	
	private static final String[] apiConfig = { "/**/apiPressure.do*" };

	private static final PathMatcher urlMatcher = new AntPathMatcher();

	public static final String USERTOKEN = "authToken";

	public static ConcurrentHashMap<Long, OnlineUser> userMap = new ConcurrentHashMap<Long, OnlineUser>();
	/**
 * 
 */
	private static final long serialVersionUID = 1L;

	private static final Logger logger = Logger
			.getLogger(MySecurityDelegatingFilter.class);

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain arg2) throws IOException, ServletException {
		// TODO Auto-generated method stub
		logger.info("in MySecurityDelegatingFilter");
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		String uri = httpRequest.getRequestURI();
		if (this.noNeedAuthConfig(uri, httpRequest)
				&& this.noNeedAdminConfig(uri, httpRequest)) {
			throw new ServletException();
		}

//		if (this.noNeedAdminConfig(uri, httpRequest))
//		{
//			if (this.isFromApi(httpRequest, uri))
//			{
//				this.checkUser(httpRequest, httpResponse);
//			}
//		}
		
		arg2.doFilter(request, response);

	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

	private boolean noNeedAuthConfig(String uri, HttpServletRequest request) {
		if (ArrayUtils.isEmpty(noAuthURIConfig)) {
			return false;
		}
		for (String ptn : noAuthURIConfig) {
			if (urlMatcher.match(ptn, uri)) {
				return true;
			}
		}
		return false;
	}

	private boolean noNeedAdminConfig(String uri, HttpServletRequest request) {
		if (ArrayUtils.isEmpty(noAdminURIConfig)) {
			return false;
		}
		for (String ptn : noAdminURIConfig) {
			if (urlMatcher.match(ptn, uri)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 检查用户信息
	 * 
	 * @auther zyslovely@gmail.com
	 * @param request
	 * @param response
	 * @throws ServletException
	 */
	private void checkUser(HttpServletRequest request,
			HttpServletResponse response) throws ServletException,
			TokenNotFoundException, TokenInvalidException {
		Object obj = request.getHeader(USERTOKEN);
		if (obj == null) {
			throw new TokenNotFoundException();
		}

//		try {
//			Long userId = MyInterfaceTokenUtil.getUserIdFromToken(obj
//					.toString());
//			MyUser user = userMap.get(userId);
//			if (user == null) {
//				// 如果是空的,如果认证正确,需要重新生成一个user
//				if (userId > 0) {
//					user = new MyUser();
//					user.setAuthToken(obj.toString());
//					user.setUserId(userId);
//					user.setLastRegisterTime(new Date().getTime());
//					userMap.put(userId, user);
//				} else {
//					logger.error("TokenInvalidException where userid=" + userId
//							+ " and  token=" + obj.toString());
//					throw new TokenInvalidException();
//				}
//			} else {
//				if (!MyInterfaceTokenUtil.isValidToken(obj.toString(), user)) {
//					logger.error("TokenInvalidException where is not Valid Token userid="
//							+ userId + " and  token=" + obj.toString());
//					throw new TokenInvalidException();
//				}
//				user.setLastRegisterTime(new Date().getTime());
//			}
//
//		} catch (Exception e) {
//			throw new TokenInvalidException();
//		}
	}

	/**
	 * 来自web端的请求
	 * 
	 * @auther zyslovely@gmail.com
	 * @param request
	 * @param uri
	 * @return
	 */
	private boolean isFromApi(HttpServletRequest request, String uri) {
		if (ArrayUtils.isEmpty(apiConfig)) {
			return false;
		}
		for (String ptn : apiConfig) {
			if (urlMatcher.match(ptn, uri)) {
				return true;
			}
		}
		return false;
	}
}
