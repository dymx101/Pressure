package com.pressure.meta;

import java.io.Serializable;

import com.pressure.constant.ServerConstant;

/**
 * 
 * @ClassName: Profile
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-28
 */
public class Profile implements Serializable {
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * ID
	 */
	private long UserId;
	/**
	 * 用户名
	 */
	private String UserName;
	/**
	 * 昵称
	 */
	private String NickName;
	/**
	 * 树洞密码
	 */
	private String TreeholePassWord;
	/**
	 * 创建时间
	 */
	private long CreateTime;
	/**
	 * 更新时间
	 */
	private long LastUpdateTime;
	/**
	 * 头像url
	 */
	private String avatorUrl;
	/**
	 * 性别
	 */
	private int gender;
	/**
	 * 年龄
	 */
	private int age;
	/**
	 * 等级
	 */
	private int level;
	/**
	 * openfire的userName
	 */
	private String xmppUserName;

	/**
	 * xmpp的域
	 */
	private String domain;
	/**
	 * 神父数量
	 */
	private int maxFatherCount;
	/**
	 * 聊天者数量
	 */
	private int maxTalkerCount;
	/**
	 * 当前神父数量
	 */
	private int nowFatherCount;
	/**
	 * 当前talker数量
	 */
	private int nowTalkerCount;
	/**
	 * 在线状态,0不在线,1在线,不存数据库
	 */
	private int online;
	/**
	 * 初始化了openfire,0表示没有
	 */
	private int initedXmpp;

	public static final int ONLINE = 1;

	public static final int OFFLINE = 0;

	public enum ProfileLevel {
		User {
			@Override
			public int getValue() {
				return 0;
			}
		},
		VIP {
			@Override
			public int getValue() {
				return 1;
			}
		},
		Admin {
			@Override
			public int getValue() {
				return 2;
			}
		};
		public abstract int getValue();

		public static ProfileLevel genProfileLevel(int t) {
			for (ProfileLevel level : ProfileLevel.values()) {
				if (level.getValue() == t)
					return level;
			}
			return null;
		}
	}

	public static final String kUserId = "user_id";
	public static final String kUserName = "user_name";
	public static final String kXmppUserName = "xmpp_user_name";
	public static final String kSecretKey = "secret_key";
	public static final String kDomain = "domain";
	public static final String kAvatarUrl = "avatar_url";
	public static final String kNickName = "nick_name";
	public static final String kAge = "age";
	public static final String kGender = "gender";

	public long getUserId() {
		return UserId;
	}

	public void setUserId(long userId) {
		UserId = userId;
	}

	public String getUserName() {
		return UserName;
	}

	public void setUserName(String userName) {
		UserName = userName;
	}

	public String getNickName() {
		return NickName;
	}

	public void setNickName(String nickName) {
		NickName = nickName;
	}

	public String getTreeholePassWord() {
		return TreeholePassWord;
	}

	public void setTreeholePassWord(String treeholePassWord) {
		TreeholePassWord = treeholePassWord;
	}

	public long getCreateTime() {
		return CreateTime;
	}

	public void setCreateTime(long createTime) {
		CreateTime = createTime;
	}

	public long getLastUpdateTime() {
		return LastUpdateTime;
	}

	public void setLastUpdateTime(long lastUpdateTime) {
		LastUpdateTime = lastUpdateTime;
	}

	public String getAvatorUrl() {
		return avatorUrl;
	}

	public void setAvatorUrl(String avatorUrl) {
		this.avatorUrl = avatorUrl;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getInitedXmpp() {
		return initedXmpp;
	}

	public void setInitedXmpp(int initedXmpp) {
		this.initedXmpp = initedXmpp;
	}

	public String getXmppUserName() {
		return xmppUserName;
	}

	public void setXmppUserName(String xmppUserName) {
		this.xmppUserName = xmppUserName;
	}

	public String getDomain() {
		return domain;
	}

	public void setDomain(String domain) {
		this.domain = domain;
	}

	public static String genXmppUserName(long userId) {
		return ServerConstant.OpenFire_Domain + userId;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public int getOnline() {
		return online;
	}

	public void setOnline(int online) {
		this.online = online;
	}

	public int getMaxFatherCount() {
		return maxFatherCount;
	}

	public void setMaxFatherCount(int maxFatherCount) {
		this.maxFatherCount = maxFatherCount;
	}

	public int getMaxTalkerCount() {
		return maxTalkerCount;
	}

	public void setMaxTalkerCount(int maxTalkerCount) {
		this.maxTalkerCount = maxTalkerCount;
	}

	public int getNowFatherCount() {
		return nowFatherCount;
	}

	public void setNowFatherCount(int nowFatherCount) {
		this.nowFatherCount = nowFatherCount;
	}

	public int getNowTalkerCount() {
		return nowTalkerCount;
	}

	public void setNowTalkerCount(int nowTalkerCount) {
		this.nowTalkerCount = nowTalkerCount;
	}

	/**
	 * 获取jid
	 * 
	 * @return
	 */
	public String getJid() {
		return this.xmppUserName + "@" + this.domain;
	}

	/**
	 * 通过jId获取xmppUserName
	 * 
	 * @param jId
	 * @return
	 */
	public static String getXmppUserNameFromJid(String jId) {
		int index = jId.indexOf("@" + ServerConstant.OpenFire_Domain);
		return jId.substring(0, index);
	}
}
