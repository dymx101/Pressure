package com.pressure.util;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

/**
 * @author zhengyisheng E-mail:zhengyisheng@gmail.com
 * @version CreateTime 2012-3-29 10:05:29 Class Description
 */
public class StringUtil {

	/**
	 * 
	 * @param text
	 * @param regex1
	 * @param regex2
	 * @return
	 */
	public static String getSubString(String text, String regex1, String regex2) {
		if (text == null) {
			return null;
		}
		int index1 = text.indexOf(regex1);
		int index2 = text.indexOf(regex2);
		if (index1 < 0 || index2 < 0) {
			return null;
		}
		return text.substring(index1 + regex1.length(), index2);
	}

	/**
	 * 判断匹配列表
	 * 
	 * @param regex
	 * @param text
	 * @return
	 */
	public static List<String> pattern(String regex, String text) {
		Pattern p = Pattern.compile(regex);
		Matcher matcher = p.matcher(text);
		List<String> matchList = new ArrayList<String>();
		while (matcher.find()) {
			matchList.add(matcher.group());
		}
		return matchList;
	}

	/**
	 * 过滤特殊字符
	 * 
	 * @author LiDuanqiang
	 * @date 2011-8-16上午10:39:13
	 * @param str
	 * @return
	 * @throws PatternSyntaxException
	 */
	public static String StringFilter(String str) throws Exception {
		// 只允许字母和数字
		// String regEx = "[^a-zA-Z0-9]";
		// 清除掉所有特殊字符
		String regEx = "[`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？·]";
		Pattern p = Pattern.compile(regEx);
		Matcher m = p.matcher(str);
		return m.replaceAll("").trim();
	}

	
}
