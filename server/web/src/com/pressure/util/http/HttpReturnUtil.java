package com.pressure.util.http;

import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.pressure.constant.BasicObjectConstant;
import com.pressure.constant.ServerConstant;
import com.pressure.meta.Audio;
import com.pressure.meta.ChatType;
import com.pressure.meta.Forum;
import com.pressure.meta.FrChatGroup;
import com.pressure.meta.Picture;
import com.pressure.meta.Profile;
import com.pressure.meta.Session;
import com.pressure.meta.Treehole;
import com.pressure.util.ListUtils;

public class HttpReturnUtil {

	/**
	 * 返回data数据
	 * 
	 * @param jsonObject
	 * @param name
	 * @return
	 */
	private static void returnDataObject(JSONObject jsonObject,
			JSONObject returnObject) {
		returnObject.put(BasicObjectConstant.kReturnObject_Data, jsonObject);

	}

	/**
	 * 返回第三方登录信息
	 * 
	 * @param session
	 * @param profile
	 * @return
	 */
	public static void returnDataThirdPartLogin(Session session,
			Profile profile, JSONObject returnObject) {

		JSONObject dataObject = new JSONObject();
		if (session != null) {
			JSONObject sessionObj = new JSONObject();
			sessionObj.put("refresh_token", session.getRefreshToken());
			sessionObj.put("expire_in", session.getExpireIn());
			dataObject.put(BasicObjectConstant.kReturnObject_Session,
					sessionObj);
		}
		if (profile != null) {
			JSONObject profileObject = new JSONObject();
			profileObject.put(Profile.kUserId, profile.getUserId());
			profileObject.put(Profile.kUserName, profile.getUserName());
			profileObject.put(Profile.kAvatarUrl, profile.getAvatorUrl());
			profileObject.put(Profile.kNickName, profile.getNickName());
			profileObject.put(Profile.kAge, profile.getAge());
			profileObject.put(Profile.kGender, profile.getGender());

			JSONObject xmppObject = new JSONObject();
			xmppObject.put(Profile.kXmppUserName, profile.getXmppUserName());
			xmppObject.put(Profile.kSecretKey,
					ServerConstant.OpenFire_PassWord_Secure_Key);
			xmppObject.put(Profile.kDomain, profile.getDomain());
			profileObject.put(BasicObjectConstant.kReturnObject_XmppProfile,
					xmppObject);
			dataObject.put(BasicObjectConstant.kReturnObject_Profile,
					profileObject);
		}
		HttpReturnUtil.returnDataObject(dataObject, returnObject);
	}

	/**
	 * 刷新token
	 * 
	 * @param session
	 * @param mv
	 */
	public static void returnDataRefreshToken(Session session,
			JSONObject returnObject) {

		JSONObject dataObject = new JSONObject();
		if (session != null) {
			JSONObject sessionObj = new JSONObject();
			sessionObj.put("refresh_token", session.getRefreshToken());
			sessionObj.put("expire_in", session.getExpireIn());
			dataObject.put(BasicObjectConstant.kReturnObject_Session,
					sessionObj);
		}
		HttpReturnUtil.returnDataObject(dataObject, returnObject);
	}

	/**
	 * 返回用户匹配
	 * 
	 * @param returnObject
	 */
	public static void returnDataFrMatch(Profile toProfile,
			JSONObject returnObject, FrChatGroup chatGroup) {
		JSONObject dataObject = new JSONObject();
		JSONObject chatObj = new JSONObject();
		if (chatGroup != null) {
			chatObj.put("chat_id", chatGroup.getGroupId());
			if (toProfile.getUserId() == chatGroup.getUser1()) {
				chatObj.put("user_type", FrChatGroup.Talker); // 说明这个profile是一个talker
			} else {
				chatObj.put("user_type", FrChatGroup.Father);// 说明这个profile是一个father
			}

			dataObject.put(BasicObjectConstant.kReturnObject_Chat, chatObj);
		}
		if (toProfile != null) {
			JSONObject profileObject = new JSONObject();
			profileObject.put(Profile.kUserId, toProfile.getUserId());
			profileObject.put(Profile.kUserName, toProfile.getUserName());
			profileObject.put(Profile.kAvatarUrl, toProfile.getAvatorUrl());
			profileObject.put(Profile.kNickName, toProfile.getNickName());
			profileObject.put(Profile.kAge, toProfile.getAge());
			profileObject.put(Profile.kGender, toProfile.getGender());

			JSONObject xmppObject = new JSONObject();
			xmppObject.put(Profile.kXmppUserName, toProfile.getXmppUserName());
			xmppObject.put(Profile.kSecretKey,
					ServerConstant.OpenFire_PassWord_Secure_Key);
			xmppObject.put(Profile.kDomain, toProfile.getDomain());
			profileObject.put(BasicObjectConstant.kReturnObject_XmppProfile,
					xmppObject);
			chatObj.put(BasicObjectConstant.kReturnObject_Profile,
					profileObject);
		}
		dataObject.put(BasicObjectConstant.kReturnObject_Chat, chatObj);
		HttpReturnUtil.returnDataObject(dataObject, returnObject);
	}

	/**
	 * 返回树洞信息
	 * 
	 * @param treehole
	 * @param returnObject
	 */
	public static void returnDataTreehole(List<Treehole> treeholeList,
			JSONObject returnObject) {
		JSONObject dataObject = new JSONObject();
		JSONArray treeholeArray = new JSONArray();
		if (!ListUtils.isEmptyList(treeholeList)) {
			for (Treehole treehole : treeholeList) {
				JSONObject treeholeObject = new JSONObject();
				treeholeObject.put(Treehole.KTREEHOLE_ID, treehole.getId());
				treeholeObject.put(Treehole.KTREEHOLE_USERID,
						treehole.getUserId());
				treeholeObject.put(Treehole.KTREEHOLE_PICTRUEURL,
						treehole.getPictureUrl());
				treeholeObject.put(Treehole.KTREEHOLE_VOICE,
						treehole.getVoice());
				treeholeObject.put(Treehole.KTREEHOLE_LOCATION,
						treehole.getLocation());
				treeholeObject.put(Treehole.KTREEHOLE_CONTENT,
						treehole.getContent());
				treeholeObject.put(Treehole.KTREEHOLE_CREATETIME,
						treehole.getCreateTime());
				treeholeObject.put(Treehole.KTREEHOLE_LASTUPDATETIME,
						treehole.getLastUpdateTime());
				treeholeArray.add(treeholeObject);
			}
		}
		dataObject.put("treeholeList", treeholeArray);
		dataObject.put(BasicObjectConstant.kReturnObject_Treehole, dataObject);
		HttpReturnUtil.returnDataObject(dataObject, returnObject);
	}

	/**
	 * 
	 * @param chatTypeList
	 * @param returnObject
	 */
	public static void returnChatTypeList(List<ChatType> chatTypeList,
			JSONObject returnObject) {
		JSONObject dataObject = new JSONObject();
		JSONArray chatTypeArray = new JSONArray();
		for (ChatType chatType : chatTypeList) {
			JSONObject chatTypeObject = new JSONObject();
			chatTypeObject.put(ChatType.kChatType_Id, chatType.getId());
			chatTypeObject.put(ChatType.kChatType_Name, chatType.getName());
			chatTypeArray.add(chatTypeObject);
		}
		dataObject.put(BasicObjectConstant.kReturnObject_ChatType_List,
				chatTypeArray);
		HttpReturnUtil.returnDataObject(dataObject, returnObject);
	}

	/**
	 * 论坛列表
	 * 
	 * @param forumList
	 * @param returnObject
	 */
	public static void returnForumList(List<Forum> forumList,
			JSONObject returnObject) {
		JSONObject dataObject = new JSONObject();
		JSONArray forumArray = new JSONArray();
		if (ListUtils.isEmptyList(forumList)) {
			dataObject.put(BasicObjectConstant.kReturnObject_Forum_List,
					forumArray);
			HttpReturnUtil.returnDataObject(dataObject, returnObject);
			return;
		}
		for (Forum forum : forumList) {
			JSONObject forumObject = new JSONObject();
			forumObject.put(Forum.kForum_Id, forum.getId());
			forumObject.put(Forum.kText, forum.getText());
			forumObject.put(Forum.kCreateTime, forum.getCreateTime());
			forumObject.put(Forum.kUpdateTime, forum.getUpdateTime());
			forumObject.put(Forum.kChatType, forum.getChatType());

			Profile profile = forum.getProfile();
			if (profile != null) {
				JSONObject profileObject = new JSONObject();
				profileObject.put(Profile.kUserId, profile.getUserId());
				profileObject.put(Profile.kNickName, profile.getNickName());

				JSONObject xmppObject = new JSONObject();
				xmppObject
						.put(Profile.kXmppUserName, profile.getXmppUserName());
				xmppObject.put(Profile.kDomain, profile.getDomain());
				profileObject.put(
						BasicObjectConstant.kReturnObject_XmppProfile,
						xmppObject);
				forumObject.put(BasicObjectConstant.kReturnObject_Profile,
						profileObject);
			}
			Picture picture = forum.getPicture();
			if (picture != null) {
				JSONObject pictureObject = new JSONObject();
				pictureObject.put(Picture.kPictureUrl, picture.getPictureUrl());
				pictureObject.put(Picture.kFileSize, picture.getFileSize());
				pictureObject.put(Picture.kWidth, picture.getWidth());
				pictureObject.put(Picture.kHeight, picture.getHeight());
				forumObject.put(BasicObjectConstant.kReturnObject_Picture,
						pictureObject);
			}
			Audio audio = forum.getAudio();
			if (audio != null) {
				JSONObject audioObject = new JSONObject();
				audioObject.put(Audio.kAudioUrl, audio.getAudioUrl());
				audioObject.put(Audio.kAudioSec, audio.getAudioSec());
				audioObject.put(Audio.kFileSize, audio.getFileSize());
				forumObject.put(BasicObjectConstant.kReturnObject_Audio,
						audioObject);
			}
			forumArray.add(forumObject);
		}
		dataObject
				.put(BasicObjectConstant.kReturnObject_Forum_List, forumArray);
		HttpReturnUtil.returnDataObject(dataObject, returnObject);
	}
}
