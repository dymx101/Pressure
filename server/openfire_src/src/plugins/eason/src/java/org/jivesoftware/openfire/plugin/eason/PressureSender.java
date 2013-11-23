package org.jivesoftware.openfire.plugin.eason;

import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

public class PressureSender {

	private static final String HOST = "http://127.0.0.1/Pressure/apiXmpp.do";

	private static PressureSender uniqueInstance = null;

	public static PressureSender getInstance() {
		if (uniqueInstance == null) {
			uniqueInstance = new PressureSender();
		}
		return uniqueInstance;
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

			e.printStackTrace();
		} catch (IOException e) {

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
