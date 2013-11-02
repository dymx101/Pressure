package com.pressure.api.test;

import net.sf.json.JSONObject;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.RequestEntity;
import org.apache.commons.httpclient.methods.StringRequestEntity;

public class TestRefreshToken {
	public static void main(String[] args) {

		String strURL = "http://127.0.0.1:8080/Pressure/apiPressure.do?action=refreshToken";
		HttpClient httpclient = new HttpClient();
		PostMethod post = new PostMethod(strURL);

		try {


			JSONObject requestObject = new JSONObject();
			
			post.addRequestHeader("Authorization",
					"bb796e96-a4ef-41a9-89f3-2a49535812f2");
			post.addRequestHeader("UserName", "allin02");

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
