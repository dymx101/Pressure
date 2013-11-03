package com.pressure.constant;

/**
 * 
 * @ClassName: ReturnCodeConstant
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-29 ����05:57:29
 */
public class ReturnCodeConstant {

	public static final int INNEREXCEPTION = -100;
	/**
	 * 失败
	 */
	public static final int FAILED = -1;
	/**
	 * 成功
	 */
	public static final int SUCCESS = 1;
	/**
	 * 用户找不到
	 */
	public static final int UserNoFound = -10;
	/**
	 * api的参数找不到
	 */
	public static final int ParamNotFound = -11;

	/**
	 * token找不到
	 */
	public static final int TokenNotFound = -100;
	/**
	 * token失效
	 */
	public static final int TokenIsInvalid = -101;

}
