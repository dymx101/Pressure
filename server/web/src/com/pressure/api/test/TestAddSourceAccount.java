package com.pressure.api.test;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;

/**
 * 
 * @ClassName: TestAddSourceAccount
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-30 ÏÂÎç03:35:03
 */
public class TestAddSourceAccount {

	public static void main(String[] args) {
		String strURL = "http://pressure.zys-wings.com/pressure/api/sourceaccount/?uid=1&accesstoken=asdfghjkl&expires_in=11111&type=0";
		// Get file to be posted
		HttpClient httpclient = new HttpClient();
		PostMethod post = new PostMethod(strURL);
		// post.setRequestHeader(
		// "Authorization",
		// "token=\"U7elprSC7LZEc2ibVuappkxmFwPMkzImN.a0RtmqkwPmt.nVltzn6daMtalk_Wp7uiHM._jH_NNPZAlDqlcNKu5XWm0aokHOCMRfNVgz.jvq5CYW86MsP7qUHHEuWlfkp\"");

		try {
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
