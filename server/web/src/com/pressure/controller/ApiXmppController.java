package com.pressure.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;

import com.pressure.constant.ReturnCodeConstant;
import com.pressure.constant.ServerConstant;
import com.pressure.service.ProfileService;

@Controller("apiXmppController")
public class ApiXmppController extends AbstractBaseController {

	@Resource
	private ProfileService profileService;

	public ModelAndView doSomeThingFromOpenFire(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView(ServerConstant.Api_Return_MV);

		String operation = request.getParameter("operation");
		
		
		return mv;
	}
}
