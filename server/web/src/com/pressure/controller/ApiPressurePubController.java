package com.pressure.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;

import com.pressure.constant.BasicObjectConstant;
import com.pressure.constant.ReturnCodeConstant;
import com.pressure.service.SourceAccountService;

/**
 * 
 * @ClassName: ApiPressurePubController
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-30 01:09:05
 */
@Controller("apiPressurePubController")
public class ApiPressurePubController extends AbstractBaseController {
	private static final Logger logger = Logger
			.getLogger(ApiPressurePubController.class);

	@Resource
	private SourceAccountService sourceAccountService;

	/**
	 * 刷新token操作
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView refreshToken(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView modelAndView = new ModelAndView("return");
		return modelAndView;
	}

	/**
	 * 第三方登录操作
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView thirdPartLogin(HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView modelAndView = new ModelAndView("return");

		String jsonString = PostValueGetUtil.parseRequestAsString(request,
				"utf-8");
		JSONObject jsonObject = PostValueGetUtil.parseRequestData(jsonString);
		JSONObject returnObject = new JSONObject();
		if (jsonObject == null) {
			returnObject.put(BasicObjectConstant.kReturnObject_Code,
					ReturnCodeConstant.FAILED);
			modelAndView.addObject("returnObject", returnObject.toString());
			return modelAndView;
		}
		String access_token = ServletRequestUtils.getStringParameter(request,
				"access_token", null);
		String expires_in = ServletRequestUtils.getStringParameter(request,
				"expires_in", null);
		long uid = ServletRequestUtils.getLongParameter(request, "uid", -1L);
		int type = ServletRequestUtils.getIntParameter(request, "type", -1);

		if (sourceAccountService.addSourceAccount(uid, access_token,
				expires_in, type)) {
			returnObject.put(BasicObjectConstant.kReturnObject_Code,
					ReturnCodeConstant.SUCCESS);
			modelAndView.addObject("returnObject", returnObject.toString());
			return modelAndView;
		}
		returnObject.put(BasicObjectConstant.kReturnObject_Code,
				ReturnCodeConstant.FAILED);
		modelAndView.addObject("returnObject", returnObject.toString());
		return modelAndView;
	}
}
