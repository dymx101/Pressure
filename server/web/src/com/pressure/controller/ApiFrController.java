package com.pressure.controller;

import java.util.List;

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
		frChatGroup.setTalkerProfile(userProfile);
		HttpReturnUtil.returnDataFrMatch(returnObject, frChatGroup);
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
			return this.errorWithErrorCode(mv,
					ReturnCodeConstant.FatherUserNotFound);
		}
		// 只要添加好友成功，就认为成功了
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
		chatGroup.setFatherProfile(fatherProfile);
		HttpReturnUtil.returnDataFrMatch(returnObject, chatGroup);
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
		int type = -1;
		// 当前用户的类型
		if (jsonObject.get("type") != null) {
			type = jsonObject.getInt("type");
		}
		long userId = Long.valueOf(request.getHeader("userId"));
		Profile jidprofile = profileService
				.getProfileByXmppUserName(xmppUserName);
		if (jidprofile == null) {
			return this.errorWithErrorCode(mv, ReturnCodeConstant.UserNoFound);
		}
		FrChatGroup chatGroup = null;
		// to 是talker
		if (type == FrWantChatType.VisitTalker) {
			chatGroup = frChatGroupService.getFrChatGroup(userId,
					jidprofile.getUserId());
			chatGroup.setTalkerProfile(jidprofile);
		} else if (type == FrWantChatType.VisitFather) {
			chatGroup = frChatGroupService.getFrChatGroup(
					jidprofile.getUserId(), userId);
			chatGroup.setFatherProfile(jidprofile);
		} else {
			chatGroup = frChatGroupService.getFrChatGroup(userId,
					jidprofile.getUserId());
			if (chatGroup == null) {
				chatGroup = frChatGroupService.getFrChatGroup(
						jidprofile.getUserId(), userId);
				if (chatGroup != null) {
					chatGroup.setFatherProfile(jidprofile);
				}

			} else {
				chatGroup.setTalkerProfile(jidprofile);
			}
			// 如果聊天组为空,返回错误
			if (chatGroup == null) {
				return this.errorWithErrorCode(mv,
						ReturnCodeConstant.NoChatingGroup);
			}
		}
		HttpReturnUtil.returnGetUserProfileByJid(returnObject, chatGroup,type);
		returnObject.put(BasicObjectConstant.kReturnObject_Code,
				ReturnCodeConstant.SUCCESS);
		mv.addObject("returnObject", returnObject.toString());
		return mv;
	}

	/**
	 * 同步当前用户的聊天人群
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView syncUserChatingUsers(HttpServletRequest request,
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
		int type = jsonObject.getInt("type");
		int limit = jsonObject.getInt("limit");
		long updateTime = jsonObject.getInt("update_time");
		if (type == FrWantChatType.VisitFather) {
			List<FrChatGroup> fatherGroups = frChatGroupService
					.getChatGroupsByType(userId, FrWantChatType.VisitFather,
							limit, updateTime);
			HttpReturnUtil.returnSyncChatingUser(fatherGroups, null,
					returnObject);
		} else {
			List<FrChatGroup> talkerGroups = frChatGroupService
					.getChatGroupsByType(userId, FrWantChatType.VisitTalker,
							limit, updateTime);
			HttpReturnUtil.returnSyncChatingUser(null, talkerGroups,
					returnObject);
		}
		returnObject.put(BasicObjectConstant.kReturnObject_Code,
				ReturnCodeConstant.SUCCESS);
		mv.addObject("returnObject", returnObject.toString());
		return mv;
	}

}
