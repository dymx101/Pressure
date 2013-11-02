package com.pressure.api.test;

import net.sf.json.JSONObject;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.RequestEntity;
import org.apache.commons.httpclient.methods.StringRequestEntity;

/**
 * 
 * @ClassName: TestAddSourceAccount
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-30 03:35:03
 */
public class TestAddSourceAccount {

	public static void main(String[] args) {

		String strURL = "http://127.0.0.1:8080/Pressure/apiPressurePub.do?action=sourceAccountLogin";
		HttpClient httpclient = new HttpClient();
		PostMethod post = new PostMethod(strURL);

		try {

			JSONObject object = new JSONObject();
			object.put("access_token", "10074216906");
			object.put("expires_in", 111111);
			object.put("uid", 11111);
			object.put("type", 1);

			JSONObject requestObject = new JSONObject();
			requestObject.put("requestData", object.toString());
			post.addRequestHeader("Authorization",
					"bb796e96-a4ef-41a9-89f3-2a49535812f2");
			post.addRequestHeader("UserId", "allin02");

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
