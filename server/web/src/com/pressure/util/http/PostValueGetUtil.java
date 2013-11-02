package com.pressure.util.http;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

public class PostValueGetUtil {

	private static Logger logger = Logger.getLogger(PostValueGetUtil.class);
	/**
	 * xml长度
	 */
	public static final int MAX_LENGTH_XML = 1024;

	/**
	 * 解析请求
	 * 
	 * @param request
	 * @param encoding
	 * @return
	 */
	public static String parseRequestAsString(HttpServletRequest request,
			String encoding) {
		InputStream in = null;
		BufferedInputStream bufInput = null;
		ByteArrayOutputStream out = null;
		try {
			in = request.getInputStream();
			bufInput = new BufferedInputStream(in);
			out = new ByteArrayOutputStream();
			byte[] b = new byte[MAX_LENGTH_XML];
			int c = 0;
			while ((c = bufInput.read(b)) != -1) {
				out.write(b, 0, c);
			}
			return (encoding == null) ? out.toString() : out.toString(encoding);
		} catch (IOException e) {
			logger.error("HttpServletUtil parseRequestAsString io error!");
			return null;
		} finally {
			IOUtils.closeQuietly(bufInput);
			IOUtils.closeQuietly(in);
			IOUtils.closeQuietly(out);
		}
	}

	/**
	 * 
	 * @param jsonString
	 * @return
	 */
	public static JSONObject parseRequestData(String jsonString) {
		if (StringUtils.isEmpty(jsonString)) {
			return null;
		}
		JSONObject jsonObject = JSONObject.fromObject(jsonString);
		return (JSONObject) jsonObject.get("requestData");
	}

}
