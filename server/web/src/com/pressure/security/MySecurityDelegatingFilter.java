package com.pressure.security;

import java.io.IOException;
import java.util.Date;
import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.Resource;
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
import org.springframework.stereotype.Service;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.PathMatcher;

import com.pressure.meta.OnlineUser;
import com.pressure.service.ProfileService;


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

		if (this.noNeedAdminConfig(uri, httpRequest)) {
			if (this.isFromApi(httpRequest, uri)) {

			}
		}

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
	 * 是否来自api接口
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
