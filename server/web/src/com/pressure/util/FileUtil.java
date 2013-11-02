package com.pressure.util;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.log4j.Logger;

/**
 * @author zhengyisheng E-mail:zhengyisheng@gmail.com
 * @version CreateTime：2012-9-11 下午02:50:00 Class Description
 */
public class FileUtil {

	private static final Logger logger = Logger.getLogger(FileUtil.class);

	/**
	 * 创建目录
	 * 
	 * @param distPath
	 */
	public static void CreateDir(String distPath) throws Exception {
		File file = new File(distPath);
		if (!file.exists()) {
			file.mkdirs();
		}
	}

	/**
	 * url转file
	 * 
	 * @param urlStr
	 * @return
	 */
	public static File getFileFromUrl(String urlStr, String path) {
		try {
			URL url = new URL(urlStr);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			DataInputStream in = new DataInputStream(connection.getInputStream());
			DataOutputStream out = new DataOutputStream(new FileOutputStream(path));
			byte[] buffer = new byte[4096];
			int count = 0;
			while ((count = in.read(buffer)) > 0) {
				out.write(buffer, 0, count);
			}
			out.close();
			in.close();
			return new File(path);
		} catch (Exception e) {
			logger.error("FileUtil getFileFromUrl where url=" + urlStr + " path=" + path);
			e.printStackTrace();
			return null;
		}
	}
}
