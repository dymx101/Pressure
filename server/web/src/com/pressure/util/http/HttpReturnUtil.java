package com.pressure.util.http;

import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.pressure.constant.BasicObjectConstant;
import com.pressure.constant.ServerConstant;
import com.pressure.meta.FrChatGroup;
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
			profileObject.put("user_id", profile.getUserId());
			profileObject.put("user_name", profile.getUserName());
			profileObject.put("avatar_url", profile.getAvatorUrl());
			profileObject.put("nick_name", profile.getNickName());
			profileObject.put("age", profile.getAge());
			profileObject.put("gender", profile.getGender());

			JSONObject xmppObject = new JSONObject();
			xmppObject.put("xmpp_user_name", profile.getXmppUserName());
			xmppObject.put("secret_key",
					ServerConstant.OpenFire_PassWord_Secrect_Key);
			xmppObject.put("domain", profile.getDomain());
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
	public static void returnDataFrMatch(Profile profile,
			JSONObject returnObject, FrChatGroup chatGroup) {
		JSONObject dataObject = new JSONObject();
		if (profile != null) {
			JSONObject profileObject = new JSONObject();
			profileObject.put("user_id", profile.getUserId());
			profileObject.put("user_name", profile.getUserName());
			profileObject.put("avatar_url", profile.getAvatorUrl());
			profileObject.put("nick_name", profile.getNickName());
			profileObject.put("age", profile.getAge());
			profileObject.put("gender", profile.getGender());
			
			JSONObject xmppObject = new JSONObject();
			xmppObject.put("xmpp_user_name", profile.getXmppUserName());
			xmppObject.put("secret_key",
					ServerConstant.OpenFire_PassWord_Secrect_Key);
			xmppObject.put("domain", profile.getDomain());
			profileObject.put(BasicObjectConstant.kReturnObject_XmppProfile,
					xmppObject);
			dataObject.put(BasicObjectConstant.kReturnObject_Profile,
					profileObject);
		}
		if (chatGroup != null) {
			JSONObject groupObj = new JSONObject();
			groupObj.put("group_id", chatGroup.getGroupId());
			groupObj.put("group_name", chatGroup.getGroupName());
			dataObject.put(BasicObjectConstant.kReturnObject_XmppGroup,
					groupObj);
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
		dataObject.put("treeholeList", treeholeArray.toString());
		dataObject.put(BasicObjectConstant.kReturnObject_Treehole, dataObject);
		HttpReturnUtil.returnDataObject(dataObject, returnObject);
	}
}
