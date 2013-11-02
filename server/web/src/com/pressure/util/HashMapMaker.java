package com.pressure.util;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * hashMapMaker
 * @author apple
 * 
 */
public final class HashMapMaker {
	private HashMapMaker() {

	}

	public static <T> Map<Long, T> listToMap(List<T> list, String methodName, Class class1) {
		if (list == null || list.size() == 0) {
			return new HashMap<Long, T>();
		}
		Map<Long, T> pMap = new HashMap<Long, T>(list.size());
		try {
			Method method = class1.getMethod(methodName);
			for (T t : list) {
				Long aLong = (Long) method.invoke(t);
				pMap.put(aLong, t);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pMap;
	}
}
