package com.pressure.controller;

import java.util.Date;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MethodNameResolver;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.pressure.constant.BasicObjectConstant;
import com.pressure.constant.ReturnCodeConstant;
import com.pressure.meta.Session;
import com.pressure.service.ProfileService;

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

	private static final Logger logger = Logger
			.getLogger(AbstractBaseController.class);

	@Resource
	protected ProfileService profileService;

	/**
	 * json解析错误返回
	 * 
	 * @param mv
	 * @param jsonObject
	 * @return
	 */
	public ModelAndView jsonErrorReturn(ModelAndView mv, String jsonString) {
		JSONObject returnObject = new JSONObject();
		logger.error("refreshToken ReturnCodeConstant where jsonString = "
				+ jsonString);
		returnObject.put(BasicObjectConstant.kReturnObject_Code,
				ReturnCodeConstant.ParamNotFound);
		mv.addObject("returnObject", returnObject.toString());
		return mv;
	}

	/**
	 * token认证失败
	 * 
	 * @param mv
	 * @param returnCode
	 * @return
	 */
	public ModelAndView tokenErrorReturn(ModelAndView mv, int returnCode) {
		JSONObject returnObject = new JSONObject();
		returnObject.put(BasicObjectConstant.kReturnObject_Code, returnCode);
		mv.addObject("returnObject", returnObject.toString());
		return mv;
	}

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
			Session session = profileService
					.getSessionByRefreshToken(refreshToken);
			// token不存在
			if (session == null || session.getUserId() != userId) {

				return ReturnCodeConstant.TokenNotFound;
			}
			// token已经失效
			long nowTime = new Date().getTime();
			if (nowTime > session.getCreateTime() + session.getExpireIn()) {
				return ReturnCodeConstant.TokenIsInvalid;
			}
			return ReturnCodeConstant.SUCCESS;
		} catch (Exception e) {
			return ReturnCodeConstant.FAILED;
		}
	}

}
