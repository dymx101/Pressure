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
import com.pressure.meta.FrWantChatType;
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
			JSONObject profileObject = HttpReturnUtil.returnUserProfileObj(
					profile, true);
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
	 * 返回同步用户列表
	 * 
	 * @param fatherGroups
	 * @param talkerGroups
	 */
	public static void returnSyncChatingUser(List<FrChatGroup> fatherGroups,
			List<FrChatGroup> talkerGroups, JSONObject returnObject) {
		JSONObject dataObject = new JSONObject();
		JSONArray fatherArray = new JSONArray();
		if (!ListUtils.isEmptyList(fatherGroups)) {
			for (FrChatGroup chatGroup : fatherGroups) {
				JSONObject subObj = HttpReturnUtil.returnChat(chatGroup, true,
						true);
				fatherArray.add(subObj);
			}
			dataObject.put(BasicObjectConstant.kReturnObject_Father_List,
					fatherArray);
		}

		if (!ListUtils.isEmptyList(talkerGroups)) {
			JSONArray talkerArray = new JSONArray();
			for (FrChatGroup chatGroup : talkerGroups) {
				JSONObject subObj = HttpReturnUtil.returnChat(chatGroup, false,
						true);
				talkerArray.add(subObj);
			}
			dataObject.put(BasicObjectConstant.kReturnObject_Talker_List,
					talkerArray);
		}

		HttpReturnUtil.returnDataObject(dataObject, returnObject);

	}

	/**
	 * 返回chat信息
	 * 
	 * @param chatGroup
	 * @return
	 */
	private static JSONObject returnChat(FrChatGroup chatGroup,
			boolean returnFatherProfile, boolean returnProfile) {
		JSONObject dataObject = new JSONObject();
		JSONObject chatObj = new JSONObject();
		Profile profile = null;
		if (returnProfile) {
			if (returnFatherProfile) {
				profile = chatGroup.getFatherProfile();
			} else {
				profile = chatGroup.getTalkerProfile();
			}
		}
		if (chatGroup != null && profile != null) {
			chatObj.put("chat_id", chatGroup.getGroupId());
			if (returnFatherProfile) {
				chatObj.put("user_type", FrWantChatType.VisitFather);
			} else {
				chatObj.put("user_type", FrWantChatType.VisitTalker);
			}
		}
		if (profile != null) {
			JSONObject profileObject = HttpReturnUtil.returnUserProfileObj(
					profile, false);
			if (returnFatherProfile)
			{
				chatObj.put(BasicObjectConstant.kReturnObject_Father_Profile,
						profileObject);
			}else
			{
				chatObj.put(BasicObjectConstant.kReturnObject_Talker_Profile,
						profileObject);
			}
			
		}
		dataObject.put(BasicObjectConstant.kReturnObject_Chat, chatObj);
		return dataObject;
	}

	/**
	 * 返回用户信息
	 * 
	 * @param profile
	 * @param isOwner
	 * @return
	 */
	private static JSONObject returnUserProfileObj(Profile profile,
			boolean isOwner) {
		JSONObject profileObject = new JSONObject();
		profileObject.put(Profile.kUserId, profile.getUserId());
		profileObject.put(Profile.kUserName, profile.getUserName());
		profileObject.put(Profile.kAvatarUrl, profile.getAvatorUrl());
		profileObject.put(Profile.kNickName, profile.getNickName());
		profileObject.put(Profile.kAge, profile.getAge());
		profileObject.put(Profile.kGender, profile.getGender());

		JSONObject xmppObject = new JSONObject();
		xmppObject.put(Profile.kXmppUserName, profile.getXmppUserName());
		if (isOwner) {
			xmppObject.put(Profile.kSecretKey,
					ServerConstant.OpenFire_PassWord_Secure_Key);
		}
		xmppObject.put(Profile.kDomain, profile.getDomain());
		profileObject.put(BasicObjectConstant.kReturnObject_XmppProfile,
				xmppObject);
		return profileObject;
	}

	/**
	 * 返回用户匹配
	 * 
	 * @param returnObject
	 */
	public static void returnDataFrMatch(JSONObject returnObject,
			FrChatGroup chatGroup) {
		JSONObject dataObject = HttpReturnUtil.returnChat(chatGroup, true,
				true);
		HttpReturnUtil.returnDataObject(dataObject, returnObject);
	}

	/**
	 * 返回用户匹配
	 * 
	 * @param returnObject
	 */
	public static void returnGetUserProfileByJid(JSONObject returnObject,
			FrChatGroup chatGroup,int type) {
		JSONObject dataObject;
		if (type == FrWantChatType.VisitFather)
		{
			dataObject = HttpReturnUtil.returnChat(chatGroup, true,
					true);
		}else 
		{
			dataObject = HttpReturnUtil.returnChat(chatGroup, false,
					true);
		}
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
				JSONObject profileObject = HttpReturnUtil.returnUserProfileObj(
						profile, false);
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
