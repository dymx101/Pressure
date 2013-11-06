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
import com.pressure.service.ProfileService;
import com.pressure.util.http.PostValueGetUtil;

/**
 * 
 * @ClassName: ApiTreeholeController
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-11-6 下午01:52:01
 */
@Controller("apiTreeholeController")
public class ApiTreeholeController extends AbstractBaseController {

	private static final Logger logger = Logger
			.getLogger(ApiTreeholeController.class);

	@Resource
	private ProfileService profileService;

	/**
	 * 设置树洞密码
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView setTreeholePassWord(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView(ServerConstant.Api_Return_MV);
		JSONObject returnObject = new JSONObject();

		String jsonString = PostValueGetUtil.parseRequestAsString(request,
				"utf-8");
		JSONObject jsonObject = PostValueGetUtil.parseRequestData(jsonString);
		if (jsonObject == null) {
			return this.jsonErrorReturn(mv, jsonString);
		}

		long userId = jsonObject.getLong("userId");
		String newTreeholePassWord = jsonObject
				.getString("newTreeholePassWord");

		if (userId < 0 || newTreeholePassWord == null) {
			returnObject.put(BasicObjectConstant.kReturnObject_Code,
					ReturnCodeConstant.FAILED);
			mv.addObject("returnObject", returnObject.toString());
			return mv;
		}

		if (profileService.updateTreeholePassword(userId, newTreeholePassWord)) {
			returnObject.put(BasicObjectConstant.kReturnObject_Code,
					ReturnCodeConstant.SUCCESS);
			mv.addObject("returnObject", returnObject.toString());
			return mv;
		}

		returnObject.put(BasicObjectConstant.kReturnObject_Code,
				ReturnCodeConstant.FAILED);
		mv.addObject("returnObject", returnObject.toString());
		return mv;
	}
}
