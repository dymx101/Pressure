package com.pressure.util.http;

import net.sf.json.JSONObject;

import org.springframework.web.servlet.ModelAndView;

import com.pressure.constant.BasicObjectConstant;
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
			dataObject.put(BasicObjectConstant.kReturnObject_Session, session);
		}
		if (profile != null) {
			JSONObject profileObject = new JSONObject();
			profileObject.put("user_id", profile.getUserId());
			profileObject.put("user_name", profile.getUserName());
			dataObject.put(BasicObjectConstant.kReturnObject_Profile, profile);
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
			dataObject.put(BasicObjectConstant.kReturnObject_Session, session);
		}
		HttpReturnUtil.returnDataObject(dataObject, returnObject);
	}

}
