package com.pressure.util;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.log4j.Logger;

/**
 * @author zhengyisheng E-mail:zhengyisheng@gmail.com
 * @version CreateTime：2012-9-9 下午09:45:13 Class Description 网络图片下载
 */
public class NetImageDownloadUtil {
	private static final Logger logger = Logger.getLogger(NetImageDownloadUtil.class);

	/**
	 * 通过url下载图片
	 * 
	 * @param url
	 * @return
	 */
	public static boolean downLoadImg(String fileUrl, String distPath) throws Exception {
		URL url = new URL(fileUrl);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		DataInputStream in = new DataInputStream(connection.getInputStream());
		DataOutputStream out = new DataOutputStream(new FileOutputStream(distPath));
		byte[] buffer = new byte[4096];
		int count = 0;
		while ((count = in.read(buffer)) > 0) {
			out.write(buffer, 0, count);
		}
		out.close();
		in.close();
		connection.disconnect();
		return true;
	}
}
