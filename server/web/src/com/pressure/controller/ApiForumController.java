package com.pressure.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;

import com.pressure.constant.BasicObjectConstant;
import com.pressure.constant.ReturnCodeConstant;
import com.pressure.constant.ServerConstant;
import com.pressure.meta.Audio;
import com.pressure.meta.Forum;
import com.pressure.meta.FrWantChatType;
import com.pressure.meta.Picture;
import com.pressure.service.ForumService;
import com.pressure.util.http.HttpReturnUtil;
import com.pressure.util.http.PostValueGetUtil;

@Controller("apiForumController")
public class ApiForumController extends AbstractBaseController {

	@Resource
	private ForumService forumService;

	/**
	 * 添加论坛内容
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView addForum(HttpServletRequest request,
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
		String text = jsonObject.getString(Forum.kText);

		JSONObject audioObject = jsonObject
				.getJSONObject(BasicObjectConstant.kReturnObject_Audio);
		Audio audio = null;
		if (audioObject != null) {
			audio = new Audio();
			audio.setAudioKey(audioObject.getString(Audio.kAudioKey));
			audio.setAudioSec(audioObject.getInt(Audio.kAudioSec));
			audio.setFileSize(audioObject.getInt(Audio.kFileSize));
		}
		JSONObject pictureObject = jsonObject
				.getJSONObject(BasicObjectConstant.kReturnObject_Picture);
		Picture picture = null;
		if (pictureObject != null) {
			picture = new Picture();
			picture.setFileSize(pictureObject.getInt(Picture.kFileSize));
			picture.setWidth(pictureObject.getInt(Picture.kWidth));
			picture.setHeight(pictureObject.getInt(Picture.kHeight));
			picture.setPictureKey(pictureObject.getString(Picture.kPictureKey));
		}
		int chatType = jsonObject.getInt(Forum.kChatType);
		Forum forum = forumService.addForum(text, audio, picture, userId,
				chatType);

		if (forum != null) {
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
	 * 获取论坛列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public ModelAndView getForumList(HttpServletRequest request,
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
		long beginTime = jsonObject.getLong("beginTime");
		int limit = jsonObject.getInt("limit");
		List<Forum> forumList = forumService.getForumsByTime(beginTime, limit);
		HttpReturnUtil.returnForumList(forumList, returnObject);
		returnObject.put(BasicObjectConstant.kReturnObject_Code,
				ReturnCodeConstant.SUCCESS);
		mv.addObject("returnObject", returnObject.toString());
		return mv;
	}
}
