package com.pressure.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.log4j.Logger;

/**
 * @author zhengyisheng E-mail:zhengyisheng@gmail.com
 * @version CreateTime：2013-2-17 上午12:09:12 Class Description
 */
public class UrlUtil {
	private static final Logger logger = Logger.getLogger(UrlUtil.class);

	/**
	 * 获取源代码
	 * 
	 * @param url
	 * @return
	 */
	public static StringBuffer getSourceCodeFromUrl(String urlStr) {
		StringBuffer contentBuffer = new StringBuffer();
		int responseCode = -1;
		HttpURLConnection connection = null;
		URL url;
		try {
			url = new URL(urlStr);
			connection = (HttpURLConnection) url.openConnection();
			connection.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");

			connection.setConnectTimeout(600000);
			connection.setReadTimeout(600000);

			responseCode = connection.getResponseCode();
			if (responseCode == -1 || responseCode >= 400) {
				logger.error("UrlUtil getSourceCodeFromUrl error where responseCode=" + responseCode);
				connection.disconnect();
				return null;
			}
			InputStream inStream = connection.getInputStream();
			InputStreamReader isInputStreamReader = new InputStreamReader(inStream, "UTF-8");
			BufferedReader bufferedReader = new BufferedReader(isInputStreamReader);
			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				contentBuffer.append(str);
			}
			inStream.close();
		} catch (Exception e) {
			e.printStackTrace();
			contentBuffer = null;
			logger.error("UrlUtil getSourceCodeFromUrl error where exception=" + e.getMessage());
		} finally {
			connection.disconnect();
		}
		return contentBuffer;

	}
}
