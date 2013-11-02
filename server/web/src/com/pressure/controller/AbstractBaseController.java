package com.pressure.controller;

import java.util.Date;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.mvc.multiaction.MethodNameResolver;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.pressure.constant.ReturnCodeConstant;
import com.pressure.mapper.SessionMapper;
import com.pressure.meta.Session;

/**
 * @author zhengyisheng E-mail:zhengyisheng@corp.netease.com
 * @version CreateTime2012-3-5 01:45:43 Class Description
 */
public abstract class AbstractBaseController extends MultiActionController {
	@Resource(name = "paramResolver")
	private MethodNameResolver methodNameResolver;

	@PostConstruct
	public void baseInit() {
		super.setMethodNameResolver(methodNameResolver);
	}

	@Resource
	private SessionMapper sessionMapper;

	/**
	 * 检查token是否有效
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public int checkTokenValid(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			String refreshToken = request.getHeader("refreshToken");
			long userId = Long.valueOf(request.getHeader("userId"));
			Session session = sessionMapper
					.getSessionByRefreshToken(refreshToken);
			if (session == null || session.getUserId() != userId) {
				return ReturnCodeConstant.tokenNotFound;
			}
			long nowTime = new Date().getTime();
			if (nowTime > session.getCreateTime() + session.getExpireIn()) {
				return ReturnCodeConstant.tokenIsInvalid;
			}
			return ReturnCodeConstant.SUCCESS;
		} catch (Exception e) {
			return ReturnCodeConstant.FAILED;
		}
	}
	
	
	

}
