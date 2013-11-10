package com.pressure.meta;

import java.io.Serializable;

/**
 * 
 * @ClassName: SourceAccount
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-29 ����09:48:44
 */
public class SourceAccount implements Serializable {
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 3L;
	/**
	 * id
	 */
	private long Id;
	/**
	 * �û�Id
	 */
	private long UserId;
	/**
	 * ��Դ�û�Id
	 */
	private long AccessUserId;
	/**
	 * ��Դ�û���
	 */
	private String AccessUserName;
	/**
	 * �û���ӦToken
	 */
	private String AccessToken;
	/**
	 * Tokenʱ��
	 */
	private String ExpiresIn;
	/**
	 * �ⲿ��Դ����
	 */
	private int SourceType;
	/**
	 * ����ʱ��
	 */
	private long CreateTime;

	public enum SourceAccountType {
		SinaWeibo {
			@Override
			public int getValue() {
				return 0;
			}
		},
		WeChat {
			@Override
			public int getValue() {
				return 1;
			}
		};
		public abstract int getValue();

		public static SourceAccountType genAccountLevel(int t) {
			for (SourceAccountType type : SourceAccountType.values()) {
				if (type.getValue() == t)
					return type;
			}
			return null;
		}
	}

	public long getId() {
		return Id;
	}

	public void setId(long id) {
		Id = id;
	}

	public long getUserId() {
		return UserId;
	}

	public void setUserId(long userId) {
		UserId = userId;
	}

	public long getAccessUserId() {
		return AccessUserId;
	}

	public void setAccessUserId(long accessUserId) {
		AccessUserId = accessUserId;
	}

	public String getAccessUserName() {
		return AccessUserName;
	}

	public void setAccessUserName(String accessUserName) {
		AccessUserName = accessUserName;
	}

	public String getAccessToken() {
		return AccessToken;
	}

	public void setAccessToken(String accessToken) {
		AccessToken = accessToken;
	}

	public String getExpiresIn() {
		return ExpiresIn;
	}

	public void setExpiresIn(String ExpiresIn) {
		this.ExpiresIn = ExpiresIn;
	}

	public int getSourceType() {
		return SourceType;
	}

	public void setSourceType(int sourceType) {
		SourceType = sourceType;
	}

	public long getCreateTime() {
		return CreateTime;
	}

	public void setCreateTime(long createTime) {
		CreateTime = createTime;
	}
}
