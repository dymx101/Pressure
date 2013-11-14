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
import com.pressure.service.FrChatGroupService;
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

	@Resource
	private FrChatGroupService frChatGroupService;

	/**
	 * 成为神父，希望找到的倾诉者
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView updateMatchType(HttpServletRequest request,
			HttpServletResponse response) 
	{
		ModelAndView mv = new ModelAndView(ServerConstant.Api_Return_MV);
		JSONObject returnObject = new JSONObject();
		int returnCode = this.checkTokenValid(request, response);
		if (returnCode == ReturnCodeConstant.TokenNotFound) {
			return this.tokenErrorReturn(mv, returnCode);
		}
		return mv;
	}
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
		long userId = Long.valueOf(request.getHeader("userId"));
		Profile profile;
		Profile toProfile;
		if (userId == 2) {
			profile = profileService.getProfileByUserId(2);
			toProfile = profileService.getProfileByUserId(3);
			boolean succ1 = openfireService.addRoster(profile.getUserName(),
					toProfile.getJid(), "", 3, "");
		} else {
			profile = profileService.getProfileByUserId(3);
			toProfile = profileService.getProfileByUserId(2);
			boolean succ1 = openfireService.addRoster(profile.getUserName(),
					toProfile.getJid(), "", 3, "");
		}

		// FrChatGroup frChatGroup = frChatGroupService.addFrChatGroupService(
		// profile, toProfile);
		// if (frChatGroup != null) {
		// boolean succ1 = openfireService.addRoster(profile.getUserName(),
		// toProfile.getJid(), "", 3, frChatGroup.getGroupName());
		// boolean succ2 = openfireService.addRoster(toProfile.getUserName(),
		// profile.getJid(), "", 3, frChatGroup.getGroupName());
		// if (!succ1 || !succ2) {
		// logger.info("why not succ");
		// }
		// }
		HttpReturnUtil.returnDataFrMatch(toProfile, returnObject, null);
		returnObject.put(BasicObjectConstant.kReturnObject_Code,
				ReturnCodeConstant.SUCCESS);
		mv.addObject("returnObject", returnObject.toString());
		return mv;
	}
}
