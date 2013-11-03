package com.pressure.meta;

import java.io.Serializable;

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
	 * 
	 */
	private String UserName;
	/**
	 * 
	 */
	private String NickName;
	/**
	 * 
	 */
	private long CreateTime;
	/**
	 * 
	 */
	private long LastUpdateTime;
	/**
	 * 
	 */
	private String AvatorUrl;
	/**
	 * 
	 */
	private int level;
	/**
	 * 初始化了openfire,0表示没有
	 */
	private int initedXmpp;

	public enum ProfileLevel {
		Member {
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
		return AvatorUrl;
	}

	public void setAvatorUrl(String avatorUrl) {
		AvatorUrl = avatorUrl;
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

}
