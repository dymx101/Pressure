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
	 * 用户已注册
	 */
	public static final int UserRegisted = -12;
	/**
	 * token找不到
	 */
	public static final int TokenNotFound = -100;
	/**
	 * token失效
	 */
	public static final int TokenIsInvalid = -101;
	/**
	 * xmpp服务器错误
	 */
	public static final int XmppServerError = -201;
	/**
	 * 论坛帖子找不到
	 */
	public static final int ForumNotFound = -301;
	/**
	 * 找到的人是自己
	 */
	public static final int MatchUserIsMe = -401;
	/**
	 * 神父没有找到
	 */
	public static final int FatherUserNotFound = -402;
	/**
	 * 没有聊天组
	 */
	public static final int NoChatingGroup = -500;

}
