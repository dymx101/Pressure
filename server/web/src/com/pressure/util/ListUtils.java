package com.pressure.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * @author NovA
 * 
 */
public final class ListUtils {

	private ListUtils() {

	}

	/**
	 * 是否为空
	 * 
	 * @param <T>
	 * @param list
	 * @return
	 */
	public static <T> boolean isEmptyList(ArrayList<T> list) {
		return list == null || list.size() == 0;
	}

	/**
	 * 是否为空
	 * 
	 * @param <T>
	 * @param list
	 * @return
	 */
	public static <T> boolean isEmptyList(List<T> list) {
		return list == null || list.size() == 0;
	}

	/**
	 * 合并list
	 * 
	 * @param <T>
	 * @param list1
	 * @param list2
	 * @return
	 */
	public static <T> List<T> unionList(List<T> list1, List<T> list2) {
		if (list1 == null && list2 == null) {
			return null;
		} else if (list1 == null && list2 != null) {
			return list2;
		} else if (list1 != null && list2 == null) {
			return list1;
		} else {
			return org.apache.commons.collections.ListUtils.union(list1, list2);
		}
	}

	/**
	 * 
	 * @param <T>
	 * @param list
	 * @param splitLength
	 * @return
	 */
	public static <T> List<List<T>> splitLongList(List<T> list, int splitLength) {
		List<List<T>> splits = new ArrayList<List<T>>();
		if (list.size() < splitLength) {
			splits.add(list);
			return splits;
		}
		List<T> idList = new ArrayList<T>();
		for (T id : list) {
			idList.add(id);
		}
		int num = idList.size() / splitLength;
		if (idList.size() % splitLength != 0) {
			++num;
		}
		for (int l = 0; l < num; ++l) {
			if (l != num - 1)
				splits.add(idList.subList(l * splitLength, (l + 1) * splitLength));
			else
				splits.add(idList.subList(l * splitLength, idList.size()));
		}
		return splits;
	}

	/**
	 * 
	 * @param <T>
	 * @param set
	 * @return
	 */
	public static <T> List<T> changeSetToList(Set<T> set) {
		if (set == null || set.size() == 0) {
			return null;
		}
		List<T> list = new ArrayList<T>(set.size());
		for (T t : set) {
			list.add(t);
		}
		return list;
	}

}
