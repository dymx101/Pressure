package com.pressure.service.impl;

import java.io.IOException;
import java.net.URLEncoder;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.pressure.constant.ServerConstant;
import com.pressure.meta.OpenfireUser;
import com.pressure.service.OpenfireService;

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
}
