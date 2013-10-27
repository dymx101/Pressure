package com.eason.web.util;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;

/**
 * @author zhengyisheng E-mail:zhengyisheng@gmail.com
 * @version CreateTime：2013-5-22 下午10:01:37
 * @see Class Description
 */
public class ExcelUtils {
	/**
	 * 得到int型的cell
	 * 
	 * @auther zyslovely@gmail.com
	 * @param row
	 * @param index
	 * @return
	 */
	public static int getIntCellValue(HSSFRow row, int index) {
		int rtn = 0;
		try {
			HSSFCell cell = row.getCell((short) index);
			rtn = (int) cell.getNumericCellValue();
		} catch (RuntimeException e) {
		}
		return rtn;
	}

	/**
	 * 得到string 型的cell
	 * 
	 * @auther zyslovely@gmail.com
	 * @param row
	 * @param index
	 * @return
	 */
	public static String getStringValue(HSSFRow row, int index) {
		String rtn = "";
		try {
			HSSFCell cell = row.getCell((short) index);
			rtn = cell.getRichStringCellValue().getString();
		} catch (RuntimeException e) {
		}
		return rtn;
	}

	/**
	 * 返回double型的cell
	 * 
	 * @auther zyslovely@gmail.com
	 * @param row
	 * @param index
	 * @return
	 */
	public static double getDoubleValue(HSSFRow row, int index) {
		double rtn = 0;
		try {

			HSSFCell cell = row.getCell((short) index);
			rtn = (double) cell.getNumericCellValue();
		} catch (RuntimeException e) {

		}
		return rtn;
	}
}
