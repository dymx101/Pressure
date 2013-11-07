package com.pressure.meta;

import java.io.Serializable;

public class Treehole implements Serializable {
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 5L;
	/**
	 * 树洞Id
	 */
	private long Id;
	/**
	 * 用户Id
	 */
	private long UserId;
	/**
	 * 图片
	 */
	private String PictureUrl;
	/**
	 * 声音
	 */
	private String Voice;
	/**
	 * 位置
	 */
	private String Location;
	/**
	 * 内容
	 */
	private String content;
	/**
	 * 创建时间
	 */
	private long CreateTime;
	/**
	 * 上次更新时间
	 */
	private long LastUpdateTime;
	/**
	 * 状态
	 */
	private int status;

	public enum TreeholeStatus {
		Active {
			@Override
			public int getValue() {
				return 0;
			}
		},
		Delete {
			@Override
			public int getValue() {
				return 1;
			}
		};
		public abstract int getValue();

		public static TreeholeStatus genTreeholeStatus(int t) {
			for (TreeholeStatus status : TreeholeStatus.values()) {
				if (status.getValue() == t)
					return status;
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

	public String getPictureUrl() {
		return PictureUrl;
	}

	public void setPictureUrl(String pictureUrl) {
		PictureUrl = pictureUrl;
	}

	public String getVoice() {
		return Voice;
	}

	public void setVoice(String voice) {
		Voice = voice;
	}

	public String getLocation() {
		return Location;
	}

	public void setLocation(String location) {
		Location = location;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

}
