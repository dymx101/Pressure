package com.pressure.api.test;

import net.sf.json.JSONObject;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.RequestEntity;
import org.apache.commons.httpclient.methods.StringRequestEntity;

public class TestSetTreeholePassWord {
	public static void main(String[] args) {

		String strURL = "http://127.0.0.1:8080/Pressure/apiTreehole.do?action=setTreeholePassWord";
		HttpClient httpclient = new HttpClient();
		PostMethod post = new PostMethod(strURL);

		try {

			JSONObject object = new JSONObject();
			object.put("userId", 13);
			object.put("newTreeholePassWord", "771234");

			JSONObject requestObject = new JSONObject();
			requestObject.put("requestData", object.toString());

			RequestEntity entity = new StringRequestEntity(
					requestObject.toString());
			// Part[] parts = { new StringPart("requestData", object.toString())
			// };
			post.setRequestEntity(entity);

			int result = httpclient.executeMethod(post);
			System.out.println("the result of post : " + result);
			System.out.println(" the response of post : "
					+ post.getResponseBodyAsString());

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("error in post");
		} finally {
			post.releaseConnection();
		}
	}
}
