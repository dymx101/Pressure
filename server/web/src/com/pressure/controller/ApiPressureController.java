package com.pressure.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;

import com.pressure.constant.BasicObjectConstant;
import com.pressure.constant.ReturnCodeConstant;
import com.pressure.constant.ServerConstant;
import com.pressure.meta.Session;
import com.pressure.util.http.HttpReturnUtil;

@Controller("apiPressureController")
public class ApiPressureController extends AbstractBaseController {

	private static final Logger logger = Logger
			.getLogger(ApiPressureController.class);

	/**
	 * 刷新token操作
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView refreshToken(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView(ServerConstant.Api_Return_MV);

		JSONObject returnObject = new JSONObject();
		int returnCode = this.checkTokenValid(request, response);
		if (returnCode == ReturnCodeConstant.TokenNotFound) {
			return this.tokenErrorReturn(mv, returnCode);
		}
		String refreshToken = request.getHeader("refreshToken");
		long userId = Long.valueOf(request.getHeader("userId"));
		Session session = profileService.updateSessionByRefreshToken(
				refreshToken, userId);
		if (session == null) {
			logger.error("refreshToken return session == null");

		}
		HttpReturnUtil.returnDataRefreshToken(session, returnObject);
		returnObject.put(BasicObjectConstant.kReturnObject_Code,
				ReturnCodeConstant.SUCCESS);
		mv.addObject("returnObject", returnObject.toString());
		return mv;
	}
}
