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
import com.pressure.exception.UserRegisteredException;
import com.pressure.meta.Profile;
import com.pressure.meta.Session;
import com.pressure.service.SourceAccountService;
import com.pressure.util.http.HttpReturnUtil;
import com.pressure.util.http.PostValueGetUtil;

/**
 * 
 * @ClassName: ApiPressurePubController
 * @Description: TODO
 * @author yunshang_734@163.com
 */
@Controller("apiPressurePubController")
public class ApiPressurePubController extends AbstractBaseController {
	private static final Logger logger = Logger
			.getLogger(ApiPressurePubController.class);

	@Resource
	private SourceAccountService sourceAccountService;

	/**
	 * 注册用户
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView registerUser(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView(ServerConstant.Api_Return_MV);

		String jsonString = PostValueGetUtil.parseRequestAsString(request,
				"utf-8");
		JSONObject jsonObject = PostValueGetUtil.parseRequestData(jsonString);
		JSONObject returnObject = new JSONObject();
		if (jsonObject == null) {
			return this.jsonErrorReturn(mv, jsonString);
		}
		String userName = jsonObject.getString("userName");
		String passWord = jsonObject.getString("passWord");

		long userId = -1;
		try {
			userId = profileService.registerUser(userName, passWord);
		} catch (UserRegisteredException e) {
			e.printStackTrace();
			return this.errorWithErrorCode(mv, ReturnCodeConstant.UserRegisted);
		}
		if (userId > 0) {
			Session session = profileService.createSessionByUserId(userId);
			Profile profile = profileService.getProfileByUserId(userId);
			HttpReturnUtil.returnDataThirdPartLogin(session, profile,
					returnObject);
			returnObject.put(BasicObjectConstant.kReturnObject_Code,
					ReturnCodeConstant.SUCCESS);
			mv.addObject("returnObject", returnObject.toString());
			return mv;
		} else {
			return this.errorWithErrorCode(mv, ReturnCodeConstant.FAILED);
		}
	}

	/**
	 * 登录操作
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView login(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView(ServerConstant.Api_Return_MV);

		String jsonString = PostValueGetUtil.parseRequestAsString(request,
				"utf-8");
		JSONObject jsonObject = PostValueGetUtil.parseRequestData(jsonString);
		JSONObject returnObject = new JSONObject();
		if (jsonObject == null) {
			return this.jsonErrorReturn(mv, jsonString);
		}

		String userName = jsonObject.getString("userName");
		String passWord = jsonObject.getString("passWord");

		Profile profile = profileService.getProfileByUserNamePassWord(userName,
				passWord);
		Session session = profileService.createSessionByUserId(profile
				.getUserId());
		if (profile != null && session != null) {
			HttpReturnUtil.returnDataThirdPartLogin(session, profile,
					returnObject);
			returnObject.put(BasicObjectConstant.kReturnObject_Code,
					ReturnCodeConstant.SUCCESS);
			mv.addObject("returnObject", returnObject.toString());
			return mv;
		} else {
			return this.errorWithErrorCode(mv, ReturnCodeConstant.FAILED);
		}
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

		ModelAndView mv = new ModelAndView(ServerConstant.Api_Return_MV);

		String jsonString = PostValueGetUtil.parseRequestAsString(request,
				"utf-8");
		JSONObject jsonObject = PostValueGetUtil.parseRequestData(jsonString);
		JSONObject returnObject = new JSONObject();
		if (jsonObject == null) {
			return this.jsonErrorReturn(mv, jsonString);
		}

		String access_token = jsonObject.getString("access_token");
		String expires_in = jsonObject.getString("expires_in");
		long uid = jsonObject.getLong("uid");
		int type = jsonObject.getInt("type");

		long userId = sourceAccountService.sourceAccountLogin(uid,
				access_token, expires_in, type);
		if (userId < 0) {
			returnObject.put(BasicObjectConstant.kReturnObject_Code,
					ReturnCodeConstant.UserNoFound);
			mv.addObject("returnObject", returnObject.toString());
			return mv;
		}

		Session session = profileService.createSessionByUserId(userId);
		Profile profile = profileService.getProfileByUserId(userId);
		HttpReturnUtil.returnDataThirdPartLogin(session, profile, returnObject);
		returnObject.put(BasicObjectConstant.kReturnObject_Code,
				ReturnCodeConstant.SUCCESS);
		mv.addObject("returnObject", returnObject.toString());
		return mv;
	}

	
}
