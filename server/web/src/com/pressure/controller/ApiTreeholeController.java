package com.pressure.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;

import com.pressure.constant.BasicObjectConstant;
import com.pressure.constant.ReturnCodeConstant;
import com.pressure.constant.ServerConstant;
import com.pressure.meta.Treehole;
import com.pressure.service.ProfileService;
import com.pressure.service.TreeholeService;
import com.pressure.util.ListUtils;
import com.pressure.util.http.HttpReturnUtil;
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

	@Resource
	private TreeholeService treeholeService;

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

		int returnCode = this.checkTokenValid(request, response);
		if (returnCode == ReturnCodeConstant.TokenNotFound) {
			return this.tokenErrorReturn(mv, returnCode);
		}
		long userId = Long.valueOf(request.getHeader("userId"));

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

	/**
	 * 新建或者修改树洞内容
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView setTreehole(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView(ServerConstant.Api_Return_MV);
		JSONObject returnObject = new JSONObject();

		String jsonString = PostValueGetUtil.parseRequestAsString(request,
				"utf-8");
		JSONObject jsonObject = PostValueGetUtil.parseRequestData(jsonString);
		if (jsonObject == null) {
			return this.jsonErrorReturn(mv, jsonString);
		}

		long id = jsonObject.getLong("id");
		long userId = jsonObject.getLong("userId");
		String pictureUrl = jsonObject.getString("pictureUrl");
		String voice = jsonObject.getString("voice");
		String location = jsonObject.getString("location");
		String content = jsonObject.getString("content");

		if (userId < 0 || pictureUrl == null || voice == null
				|| location == null || content == null) {
			returnObject.put(BasicObjectConstant.kReturnObject_Code,
					ReturnCodeConstant.FAILED);
			mv.addObject("returnObject", returnObject.toString());
			return mv;
		}

		if (id < 0) {
			if (treeholeService.addTreehole(userId, pictureUrl, voice,
					location, content)) {
				returnObject.put(BasicObjectConstant.kReturnObject_Code,
						ReturnCodeConstant.SUCCESS);
				mv.addObject("returnObject", returnObject.toString());
				return mv;
			}
		} else {
			if (treeholeService.updateTreehole(id, pictureUrl, voice, location,
					content)) {
				returnObject.put(BasicObjectConstant.kReturnObject_Code,
						ReturnCodeConstant.SUCCESS);
				mv.addObject("returnObject", returnObject.toString());
				return mv;
			}
		}

		returnObject.put(BasicObjectConstant.kReturnObject_Code,
				ReturnCodeConstant.FAILED);
		mv.addObject("returnObject", returnObject.toString());
		return mv;
	}

	/**
	 * 埋葬树洞
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView buryTreehole(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mv = new ModelAndView(ServerConstant.Api_Return_MV);
		JSONObject returnObject = new JSONObject();

		String jsonString = PostValueGetUtil.parseRequestAsString(request,
				"utf-8");
		JSONObject jsonObject = PostValueGetUtil.parseRequestData(jsonString);
		if (jsonObject == null) {
			return this.jsonErrorReturn(mv, jsonString);
		}

		long id = jsonObject.getLong("id");
		long userId = jsonObject.getLong("userId");

		if (userId < 0 || id < 0) {
			returnObject.put(BasicObjectConstant.kReturnObject_Code,
					ReturnCodeConstant.FAILED);
			mv.addObject("returnObject", returnObject.toString());
			return mv;
		}

		if (treeholeService.buryTreehole(id, userId)) {
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

	/**
	 * 获取树洞列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView getTreeholeList(HttpServletRequest request,
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
		int limit = jsonObject.getInt("limit");
		int offset = jsonObject.getInt("offset");

		if (userId < 0 || limit < 0 || offset < 0) {
			returnObject.put(BasicObjectConstant.kReturnObject_Code,
					ReturnCodeConstant.FAILED);
			mv.addObject("returnObject", returnObject.toString());
			return mv;
		}

		List<Treehole> treeholeList = treeholeService.getTreeholeList(userId,
				limit, offset);

		HttpReturnUtil.returnDataTreehole(treeholeList, returnObject);
		returnObject.put(BasicObjectConstant.kReturnObject_Code,
				ReturnCodeConstant.SUCCESS);
		mv.addObject("returnObject", returnObject.toString());
		return mv;
	}
}
