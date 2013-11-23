package com.pressure.service.impl;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.pressure.constant.ServerConstant;
import com.pressure.meta.OpenfireUser;
import com.pressure.meta.Profile;
import com.pressure.service.OpenfireService;
import com.pressure.util.ListUtils;

@Service("openfireService")
public class OpenfireServiceImpl implements OpenfireService {
	private static final Logger logger = Logger
			.getLogger(OpenfireServiceImpl.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.pressure.service.OpenfireService#createOpenfireUser(com.pressure.
	 * meta.OpenfireUser)
	 */
	@Override
	public boolean createOpenfireUser(OpenfireUser openfireUser) {
		StringBuilder sb = new StringBuilder();
		sb.append("/plugins/userService/userservice?type=add&secret="
				+ ServerConstant.OpenFire_UserService_Secret);
		sb.append("&username=" + openfireUser.getUserName());
		sb.append("&password=" + openfireUser.getPassWord());
		sb.append("&name=" + URLEncoder.encode(openfireUser.getName()));
		sb.append("&email=" + URLEncoder.encode(openfireUser.getName()));
		String returnStr = this.sendHttpRequest(ServerConstant.OpenFireIp
				+ sb.toString());
		if (returnStr.toLowerCase().contains("ok")) {
			return true;
		}
		return false;
	}

	/**
	 * 发送http请求
	 * 
	 * @param url
	 * @return
	 */
	private String sendHttpRequest(String url) {
		DefaultHttpClient httpClient = new DefaultHttpClient();// 创建HttpClient实例
		HttpGet httpGet = new HttpGet(url);// 创建httpGet

		HttpResponse response;
		HttpEntity entity = null;
		try {
			response = httpClient.execute(httpGet);
			entity = response.getEntity();// HttpClient返回的信息均以entity保存

			if (null != entity) {
				return EntityUtils.toString(entity, "UTF-8");
			}
		} catch (ClientProtocolException e) {
			logger.error("sendHttpRequest with url = " + url + " and error = "
					+ e.getMessage() + " ClientProtocolException");
			e.printStackTrace();
		} catch (IOException e) {
			logger.error("sendHttpRequest with url = " + url + " and error = "
					+ e.getMessage() + " IOException");
			e.printStackTrace();
		} finally {
			try {
				EntityUtils.consume(entity);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			httpGet.releaseConnection();// 释放链接
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.OpenfireService#addRoster(java.lang.String,
	 * java.lang.String, java.lang.String, int, java.lang.String)
	 */
	@Override
	public boolean addRoster(String fromUserName, String toJid, String name,
			int sub, String groupName) {
		StringBuilder sb = new StringBuilder();
		sb.append("/plugins/userService/userservice?type=add_roster&secret="
				+ ServerConstant.OpenFire_UserService_Secret);
		sb.append("&username=" + fromUserName);
		sb.append("&item_jid=" + toJid);
		sb.append("&name=" + URLEncoder.encode(name));
		sb.append("&sub=" + sub);
		sb.append("$groups=" + groupName);
		String returnStr = this.sendHttpRequest(ServerConstant.OpenFireIp
				+ sb.toString());
		if (returnStr.toLowerCase().contains("ok")
				|| returnStr.toLowerCase().contains(
						"useralreadyexistsexception")) {
			return true;
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.pressure.service.OpenfireService#getUsersOnlineStatus(java.util.List)
	 */
	public void getUsersOnlineStatus(List<Profile> profileList) {
		if (ListUtils.isEmptyList(profileList)) {
			return;
		}
		StringBuilder jidSb = new StringBuilder();
		int index = 0;
		for (Profile profile : profileList) {
			jidSb.append(profile.getJid());
			index++;
			if (index != profileList.size()) {
				jidSb.append(",");
			}
		}
		StringBuilder sb = new StringBuilder();
		sb.append("/plugins/presence/status?type=json&"
				+ ServerConstant.OpenFire_Secure_Key + "="
				+ ServerConstant.OpenFire_Secure_Key_Value);
		sb.append("&jids=" + jidSb);
		String returnStr = this.sendHttpRequest(ServerConstant.OpenFireIp
				+ sb.toString());
		JSONArray array = JSONArray.fromObject(returnStr);
		for (Object obj : array) {
			JSONObject object = JSONObject.fromObject(obj);
			JSONObject presenceObject = object.getJSONObject("presence");
			String jid = presenceObject.getString("jid");
			String onlineStr = presenceObject.getString("status");
			for (Profile profile : profileList) {
				if (profile.getJid().equals(jid)) {
					if (!onlineStr.equals("Unavailable")) {
						profile.setOnline(Profile.ONLINE);
					} else {
						profile.setOnline(Profile.OFFLINE);
					}
					break;
				}
			}
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.pressure.service.OpenfireService#sendTalkerFindFather(java.lang.String
	 * , java.lang.String)
	 */
	@Override
	public void sendTalkerFindFather(String fromJid, String toJid) {
		StringBuilder sb = new StringBuilder();
		sb.append("/plugins/eason/pressure?secure_key="
				+ ServerConstant.OpenFire_Secure_Key_Value);
		sb.append("&action_type=" + "talker_find_father");
		sb.append("&from_jid=" + fromJid);
		sb.append("&to_jid=" + toJid);
		this.sendHttpRequest(ServerConstant.OpenFireIp + sb.toString());
	}
}
