package com.pressure.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;

import com.pressure.service.SourceAccountService;
import com.pressure.constant.BasicObjectConstant;
import com.pressure.constant.ReturnCodeConstant;

/**
 * 
 * @ClassName: ApiPressurePubController
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-30 ÉÏÎç01:09:05
 */
@Controller("apiPressurePubController")
public class ApiPressureController {
	private static final Logger logger = Logger
			.getLogger(ApiPressureController.class);

	@Resource
	private SourceAccountService sourceAccountService;

	public ModelAndView addSourceAccount(HttpServletRequest request,
			HttpServletResponse response) {

		ModelAndView modelAndView = new ModelAndView("return");
		JSONObject returnObject = new JSONObject();

		long uid = ServletRequestUtils.getLongParameter(request, "uid", -1);
		String access_token = ServletRequestUtils.getStringParameter(request,
				"accessToken", "");
		String expires_in = ServletRequestUtils.getStringParameter(request,
				"expires_in", "");
		int type = ServletRequestUtils.getIntParameter(request, "type", -1);

		if (uid < 0 || access_token == null || expires_in == null || type < 0) {
			returnObject.put(BasicObjectConstant.kReturnObject_Code,
					ReturnCodeConstant.FAILED);
			modelAndView.addObject("returnObject", returnObject.toString());
			return modelAndView;
		}

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
