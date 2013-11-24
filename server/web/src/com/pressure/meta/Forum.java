package com.pressure.meta;

import java.io.Serializable;

public class Forum implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long id;
	private String text;
	private String prefix;
	private long createTime;
	private long updateTime;
	private long userId;
	private long audioId;
	private long pictureId;
	private int status;
	private long chatType;

	// 不存数据库
	private Picture picture;
	private Audio audio;
	private Profile profile;

	public static final String kForum_Id = "id";
	public static final String kText = "text";
	public static final String kPrefix = "prefix";
	public static final String kCreateTime = "create_time";
	public static final String kUpdateTime = "update_time";
	public static final String kUserId = "user_id";
	public static final String kStatus = "status";
	public static final String kChatType = "chat_type";

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getPrefix() {
		return prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

	public long getCreateTime() {
		return createTime;
	}

	public void setCreateTime(long createTime) {
		this.createTime = createTime;
	}

	public long getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(long updateTime) {
		this.updateTime = updateTime;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getAudioId() {
		return audioId;
	}

	public void setAudioId(long audioId) {
		this.audioId = audioId;
	}

	public long getPictureId() {
		return pictureId;
	}

	public void setPictureId(long pictureId) {
		this.pictureId = pictureId;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public long getChatType() {
		return chatType;
	}

	public void setChatType(long chatType) {
		this.chatType = chatType;
	}

	public Picture getPicture() {
		return picture;
	}

	public void setPicture(Picture picture) {
		this.picture = picture;
	}

	public Audio getAudio() {
		return audio;
	}

	public void setAudio(Audio audio) {
		this.audio = audio;
	}

	public Profile getProfile() {
		return profile;
	}

	public void setProfile(Profile profile) {
		this.profile = profile;
	}

}
