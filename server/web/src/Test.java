import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

import com.pressure.constant.ServerConstant;

/**
 * @ClassName: Test
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-28 ����01:52:17
 */
public class Test {

	public static void main(String args[]) {
		Test test = new Test();
		StringBuilder sb = new StringBuilder(
				"http://127.0.0.1:9090/plugins/presence/status?jids=admin@pressure,pressure2@pressure,pressure3@pressure&type=json&secure_key=EASON_KEY_KEY_KEY_KEY");
		String returnStr = test.sendHttpRequest(sb.toString());
		System.err.println(returnStr);
	}

	public String sendHttpRequest(String url) {
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
