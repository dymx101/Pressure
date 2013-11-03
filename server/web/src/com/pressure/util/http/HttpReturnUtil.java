package com.pressure.util.http;

import net.sf.json.JSONObject;

import com.pressure.constant.BasicObjectConstant;
import com.pressure.constant.ServerConstant;
import com.pressure.meta.Profile;
import com.pressure.meta.Session;

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
	public static void ReturnDataThirdPartLogin(Session session,
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
			dataObject.put(BasicObjectConstant.kReturnObject_Profile,
					profileObject);
			JSONObject xmppObject = new JSONObject();
			xmppObject.put("xmpp_user_name", profile.getXmppUserName());
			xmppObject.put("secret_key",
					ServerConstant.OpenFire_PassWord_Secrect_Key);
			xmppObject.put("domain", profile.getDomain());
			dataObject.put(BasicObjectConstant.kReturnObject_XmppProfile,
					xmppObject);
		}
		HttpReturnUtil.returnDataObject(dataObject, returnObject);
	}

	/**
	 * 刷新token
	 * 
	 * @param session
	 * @param mv
	 */
	public static void ReturnDataRefreshToken(Session session,
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

}
