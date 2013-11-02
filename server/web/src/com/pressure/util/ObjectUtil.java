package com.pressure.util;

import java.lang.reflect.Field;
import java.util.List;

import org.apache.commons.lang.ArrayUtils;
import org.apache.log4j.Logger;

/**
 * @author zhengyisheng E-mail:zhengyisheng@gmail.com
 * @version CreateTime 2012-3-21 01:46:22 Class Description
 */
public class ObjectUtil {
	private static final Logger logger = Logger.getLogger(ObjectUtil.class);

	/**
	 * 
	 * 
	 * @param <T>
	 * @param tObject
	 * @return
	 */
	public static <T> String getAllMessage(T tObject) {
		if (tObject == null) {
			return "";
		}
		Class classT = tObject.getClass();
		Field[] fields = classT.getFields();
		if (ArrayUtils.isEmpty(fields)) {
			return "";
		}
		StringBuilder sb = new StringBuilder();
		for (Field field : fields) {
			try {
				Object parm = field.get(tObject);
				sb.append(String.valueOf(parm));
			} catch (Exception e) {
				logger.error("get field parm error!!!");
			}
		}
		return sb.toString();
	}

	/**
	 * 
	 * @param list
	 * @return
	 */
	public static <T> boolean isEmptyList(List<T> list) {
		return list == null || list.size() == 0;
	}
}
