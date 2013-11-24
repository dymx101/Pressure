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
import com.pressure.meta.Forum;
import com.pressure.meta.FrChatGroup;
import com.pressure.meta.FrWantChatType;
import com.pressure.meta.Profile;
import com.pressure.service.ForumService;
import com.pressure.service.FrChatGroupService;
import com.pressure.service.OpenfireService;
import com.pressure.util.http.HttpReturnUtil;
import com.pressure.util.http.PostValueGetUtil;

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
	private ForumService forumService;

	@Resource
	private FrChatGroupService frChatGroupService;

	/**
	 * 论坛中找过来
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView frMatchByForum(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView(ServerConstant.Api_Return_MV);
		JSONObject returnObject = new JSONObject();
		int returnCode = this.checkTokenValid(request, response);
		if (returnCode == ReturnCodeConstant.TokenNotFound) {
			return this.tokenErrorReturn(mv, returnCode);
		}
		String jsonString = PostValueGetUtil.parseRequestAsString(request,
				"utf-8");
		JSONObject jsonObject = PostValueGetUtil.parseRequestData(jsonString);

		if (jsonObject == null) {
			return this.jsonErrorReturn(mv, jsonString);
		}
		long fromUserId = Long.valueOf(request.getHeader("userId"));
		long forum_id = jsonObject.getLong(Forum.kForum_Id);
		Forum forum = forumService.getForumById(forum_id);
		if (forum == null) {
			return this
					.errorWithErrorCode(mv, ReturnCodeConstant.ForumNotFound);
		}
		FrChatGroup frChatGroup = frChatGroupService.matchTalkerFromForum(
				fromUserId, forum);
		Profile userProfile = profileService.getProfileByUserId(forum
				.getUserId());
		if (frChatGroup == null) {
			return this.errorWithErrorCode(mv, ReturnCodeConstant.FAILED);
		}
		HttpReturnUtil
				.returnDataFrMatch(userProfile, returnObject, frChatGroup);
		returnObject.put(BasicObjectConstant.kReturnObject_Code,
				ReturnCodeConstant.SUCCESS);
		mv.addObject("returnObject", returnObject.toString());
		return mv;
	}

	/**
	 * 神父，希望找到的倾诉者
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView updateMatchType(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView(ServerConstant.Api_Return_MV);
		JSONObject returnObject = new JSONObject();
		int returnCode = this.checkTokenValid(request, response);
		if (returnCode == ReturnCodeConstant.TokenNotFound) {
			return this.tokenErrorReturn(mv, returnCode);
		}
		String jsonString = PostValueGetUtil.parseRequestAsString(request,
				"utf-8");
		JSONObject jsonObject = PostValueGetUtil.parseRequestData(jsonString);

		if (jsonObject == null) {
			return this.jsonErrorReturn(mv, jsonString);
		}
		long userId = Long.valueOf(request.getHeader("userId"));
		String ageRange = jsonObject.getString("ageRange");
		int gender = jsonObject.getInt("gender");
		int chatType = jsonObject.getInt("chatType");
		int type = jsonObject.getInt("type");
		int beginAge = -1;
		int endAge = -1;
		if (ageRange.equals("17~24")) {
			beginAge = 17;
			endAge = 24;
		}
		FrWantChatType wantChatType = frChatGroupService.addFrWantChatType(
				userId, beginAge, endAge, gender, type, chatType);
		if (wantChatType != null) {
			returnObject.put(BasicObjectConstant.kReturnObject_Code,
					ReturnCodeConstant.SUCCESS);
		} else {
			returnObject.put(BasicObjectConstant.kReturnObject_Code,
					ReturnCodeConstant.FAILED);
		}
		mv.addObject("returnObject", returnObject.toString());
		return mv;
	}

	/**
	 * 找神父
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
		String jsonString = PostValueGetUtil.parseRequestAsString(request,
				"utf-8");
		JSONObject jsonObject = PostValueGetUtil.parseRequestData(jsonString);
		if (jsonObject == null) {
			return this.jsonErrorReturn(mv, jsonString);
		}
		long userId = Long.valueOf(request.getHeader("userId"));
		String ageRange = jsonObject.getString("ageRange");
		int gender = jsonObject.getInt("gender");
		long chatType = jsonObject.getInt("chatType");

		int beginAge = -1;
		int endAge = -1;
		if (ageRange.equals("17~24")) {
			beginAge = 17;
			endAge = 24;
		}
		Profile fatherProfile = frChatGroupService.tryToFindFather(userId,
				beginAge, endAge, gender, chatType);
		Profile userProfile = profileService.getProfileByUserId(userId);
		if (fatherProfile == null) {

		}
		boolean succ = openfireService.addRoster(userProfile.getXmppUserName(),
				fatherProfile.getJid(), "", 3, "");
		if (!succ) {
			return this.errorWithErrorCode(mv,
					ReturnCodeConstant.XmppServerError);
		}
		openfireService.sendTalkerFindFather(userProfile.getJid(),
				fatherProfile.getJid());
		FrChatGroup chatGroup = frChatGroupService.addFrChatGroupService(
				fatherProfile, userProfile, FrChatGroup.FatherTalker);
		HttpReturnUtil
				.returnDataFrMatch(fatherProfile, returnObject, chatGroup);
		returnObject.put(BasicObjectConstant.kReturnObject_Code,
				ReturnCodeConstant.SUCCESS);
		mv.addObject("returnObject", returnObject.toString());
		return mv;
	}

	/**
	 * 获取用户信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView getUserProfileByJid(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView(ServerConstant.Api_Return_MV);

		JSONObject returnObject = new JSONObject();
		int returnCode = this.checkTokenValid(request, response);
		if (returnCode == ReturnCodeConstant.TokenNotFound) {
			return this.tokenErrorReturn(mv, returnCode);
		}
		String jsonString = PostValueGetUtil.parseRequestAsString(request,
				"utf-8");
		JSONObject jsonObject = PostValueGetUtil.parseRequestData(jsonString);

		if (jsonObject == null) {
			return this.jsonErrorReturn(mv, jsonString);
		}
		String xmppUserName = jsonObject.getString("xmppUserName");
		int type = jsonObject.getInt("type");
		long userId = Long.valueOf(request.getHeader("userId"));
		Profile jidprofile = profileService
				.getProfileByXmppUserName(xmppUserName);
		if (jidprofile == null) {
			return this.errorWithErrorCode(mv, ReturnCodeConstant.UserNoFound);
		}
		FrChatGroup chatGroup = null;
		// to 是talker
		if (type == FrChatGroup.Talker) {
			chatGroup = frChatGroupService.getFrChatGroup(userId,
					jidprofile.getUserId());
		} else if (type == FrChatGroup.Father) {
			chatGroup = frChatGroupService.getFrChatGroup(
					jidprofile.getUserId(), userId);
		}
		HttpReturnUtil.returnDataFrMatch(jidprofile, returnObject, chatGroup);
		returnObject.put(BasicObjectConstant.kReturnObject_Code,
				ReturnCodeConstant.SUCCESS);
		mv.addObject("returnObject", returnObject.toString());
		return mv;
	}
}
