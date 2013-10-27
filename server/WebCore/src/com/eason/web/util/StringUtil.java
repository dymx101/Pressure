package com.eason.web.util;

import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

import com.sun.org.apache.xerces.internal.impl.dv.xs.YearDV;

/**
 * @author zhengyisheng E-mail:zhengyisheng@gmail.com
 * @version CreateTime：2013-5-4 上午10:43:59
 * @see Class Description
 */
public class StringUtil {
	/**
	 * 全角转半角
	 * 
	 * @auther zyslovely@gmail.com
	 * @param input
	 * @return
	 */
	public static String ToDBC(String input) {
		char[] c = input.toCharArray();
		for (int i = 0; i < c.length; i++) {
			if (c[i] == 12288) {
				c[i] = (char) 32;
				continue;
			}
			if (c[i] > 65280 && c[i] < 65375)
				c[i] = (char) (c[i] - 65248);
		}
		return new String(c);
	}

	/**
	 * 去除中文
	 * 
	 * @auther zyslovely@gmail.com
	 * @param str
	 * @return
	 */
	public static String removeZhongWen(String str) {
		char[] chars = str.toCharArray();
		StringBuffer result = new StringBuffer("");

		for (int i = 0; i < chars.length; i++) {
			if (Character.getType(chars[i]) != Character.OTHER_LETTER) {
				result.append(chars[i]);
			}
		}
		return result.toString();
	}

	/**
	 * 是否有中文
	 * 
	 * @auther zyslovely@gmail.com
	 * @param str
	 * @return
	 */
	public static boolean hasZhongWen(String str) {
		char[] chars = str.toCharArray();
		StringBuffer result = new StringBuffer("");
		boolean hasChinese = false;
		for (int i = 0; i < chars.length; i++) {
			if (Character.getType(chars[i]) == Character.OTHER_LETTER) {
				hasChinese = true;
				break;
			}
		}
		return hasChinese;
	}

	public static boolean isAllShuziYinwen(String str) {

		if (StringUtils.isEmpty(str)) {
			return true;
		}
		Pattern pattern = Pattern.compile("[0-9a-zA-Z]*");
		return pattern.matcher(str).matches();

	}
}
