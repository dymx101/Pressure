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
import com.pressure.service.AccountService;

/**
 * 
 * @ClassName: ApiPressurePubController
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-29 ÏÂÎç04:51:30
 */
@Controller("apiPressurePubController")
public class ApiPressurePubController {

	private static final Logger logger = Logger
			.getLogger(ApiPressurePubController.class);

	@Resource
	private AccountService accountService;

	public ModelAndView getWeiboAccount(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView modelAndView = new ModelAndView("return");
		JSONObject returnObject = new JSONObject();

		String access_token = ServletRequestUtils.getStringParameter(request,
				"access_token", "");
		String expires_in = ServletRequestUtils.getStringParameter(request,
				"expires_in", "");
		String uid = ServletRequestUtils.getStringParameter(request, "uid", "");

		if (access_token == null || expires_in == null || uid == null) {
			returnObject.put(BasicObjectConstant.kReturnObject_Code,
					ReturnCodeConstant.FAILED);
			return modelAndView;
		}

		if (!accountService.setAccount(access_token, expires_in, uid)) {
			returnObject.put(BasicObjectConstant.kReturnObject_Code,
					ReturnCodeConstant.FAILED);
			modelAndView.addObject("returnObject", returnObject.toString());
			return modelAndView;
		}

		returnObject.put(BasicObjectConstant.kReturnObject_Code,
				ReturnCodeConstant.SUCCESS);
		modelAndView.addObject("returnObject", returnObject.toString());
		logger.info(returnObject.toString());

		return modelAndView;
	}
}
