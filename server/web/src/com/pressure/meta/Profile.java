package com.pressure.meta;

import java.io.Serializable;

/**
 * 
 * @ClassName: Profile
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-28 下午02:37:29
 */
public class Profile implements Serializable {
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 账户ID
	 */
	private long UserId;
	/**
	 * 账户名
	 */
	private String UserName;
	/**
	 * 昵称
	 */
	private String NickName;
	/**
	 * 创建时间
	 */
	private long CreateTime;
	/**
	 * 上次登录时间
	 */
	private long LastUpdateTime;
	/**
	 * 用户头像
	 */
	private String AvatorUrl;
	/**
	 * 用户等级
	 */
	private int level;

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
}
