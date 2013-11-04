package com.pressure.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;

import com.pressure.constant.BasicObjectConstant;
import com.pressure.constant.ReturnCodeConstant;
import com.pressure.constant.ServerConstant;
import com.pressure.meta.Profile;
import com.pressure.service.OpenfireService;
import com.pressure.util.http.HttpReturnUtil;

/**
 * 神父功能
 * 
 * @author eason
 * 
 */
@Controller("apiFrController")
public class ApiFrController extends AbstractBaseController {

	private static final Logger logger = Logger
			.getLogger(ApiFrController.class);

	@Resource
	private OpenfireService openfireService;

	/**
	 * 神父用户匹配
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView frMatch(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView(ServerConstant.Api_Return_MV);

		JSONObject returnObject = new JSONObject();
		int returnCode = this.checkTokenValid(request, response);
		if (returnCode == ReturnCodeConstant.TokenNotFound) {
			return this.tokenErrorReturn(mv, returnCode);
		}

		Profile profile = profileService.getProfileByUserId(2);
		Profile toProfile = profileService.getProfileByUserId(3);
		openfireService.addRoster(profile.getUserName(), toProfile.getJid(),
				"", 3, "");
		HttpReturnUtil.returnDataFrMatch(toProfile, returnObject);
		returnObject.put(BasicObjectConstant.kReturnObject_Code,
				ReturnCodeConstant.SUCCESS);
		mv.addObject("returnObject", returnObject.toString());
		return mv;
	}
}
