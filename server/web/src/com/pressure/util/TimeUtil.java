package com.pressure.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * @author zhengyisheng E-mail:zhengyisheng@gmail.com
 * @version CreateTime��2012-3-21 ����12:44:33 Class Description
 */
public class TimeUtil {
	/**
	 * 按毫秒换算的一分钟时间
	 */
	public static final long MINUTE_TIME = 1000 * 60L;

	/**
	 * 按毫秒换算的一小时时间
	 */
	public static final long HOUR_TIME = 1000 * 60 * 60L;

	/**
	 * 按毫秒换算的一天时间
	 */
	public static final long DAY_TIME = 1000 * 60 * 60 * 24L;

	/**
	 * 按毫秒换算的一周时间
	 */
	public static final long WEEK_TIME = 1000 * 60 * 60 * 24 * 7L;

	/**
	 * 按毫秒换算的一月时间
	 */
	public static final long MONTH_EST_TIME = 30 * DAY_TIME;

	/**
	 * 按毫秒换算的一年时间
	 */
	public static final long YEAR_EST_TIME = 365 * DAY_TIME;

	/**
	 * 得到多少时间以前
	 * 
	 * @param time
	 * @param isSimple
	 * @return
	 */
	public static String getTimeago(long time, boolean isSimple) {
		long second = 1000;
		long minute = 60 * second;
		long hour = 60 * minute;
		SimpleDateFormat format = new SimpleDateFormat("MM-dd HH:mm");
		if (isSimple) {
			format = new SimpleDateFormat("MM月dd日");
		}
		Calendar ca = Calendar.getInstance();
		ca.setTimeInMillis(time);
		String timeStr = format.format(ca.getTime());
		long now = new Date().getTime();
		long distance = now - time;
		if (distance < minute) {
			return "刚刚";
		} else if (distance >= minute && distance < minute * 5) {
			return "1分钟前";
		} else if (distance >= minute * 5 && distance < minute * 10) {
			return "5分钟前";
		} else if (distance >= minute * 5 && distance < minute * 15) {
			return "10分钟前";
		} else if (distance >= minute * 15 && distance < minute * 30) {
			return "一刻钟前";
		} else if (distance >= minute * 30 && distance < hour) {
			return "半小时前";
		} else if (distance >= minute * 30 && distance < hour * 12) {
			return (distance / hour) + "小时前";
		} else {
			if (time == 0L) {
				return "在火星";
			} else {
				return timeStr;
			}
		}
	}

	/**
	 * 得到时间format
	 * 
	 * @author
	 * @return
	 */
	public static String getFormatTime(long time) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar ca = Calendar.getInstance();
		ca.setTimeInMillis(time);
		String timeStr = format.format(ca.getTime());
		return timeStr;
	}

	/**
	 * 得到时间format精确到分钟
	 * 
	 * @param time
	 * @return
	 */
	public static String getFormatTimeInMinute(long time) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm");
		Calendar ca = Calendar.getInstance();
		ca.setTimeInMillis(time);
		String timeStr = format.format(ca.getTime());
		return timeStr;
	}

	/**
	 * 得到小时区间
	 * 
	 * @return
	 */
	public static double getBetween(long now, long time) {
		return (now - time) * 1.0 / (60 * 60 * 100);
	}

	/**
	 * 获得给定日期之前的日期long
	 * 
	 * @param startTime
	 * @param beforeTime
	 * @return
	 */
	public static long getDayBefore(long startTime, long days) {
		return startTime - days * DAY_TIME;
	}

	/**
	 * 剩下的天数
	 * 
	 * @auther zyslovely@gmail.com
	 * @param beginTime
	 * @param nowTime
	 * @param dayLong
	 * @return
	 */
	public static int leftDay(long beginTime, long nowTime, int dayLong) {
		return (int) (dayLong - (nowTime - beginTime) / DAY_TIME);
	}

	/**
	 * 得到当天凌晨的时间戳
	 * 
	 * @author Herbert
	 * @return
	 */
	public static long getDaybreakTime() {
		Calendar cal = Calendar.getInstance();
		// cal.set(Calendar.HOUR, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.MILLISECOND, 0);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		return cal.getTimeInMillis();
	}
}
