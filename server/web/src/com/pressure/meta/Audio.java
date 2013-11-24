package com.pressure.meta;

import java.io.Serializable;

import com.pressure.constant.ServerConstant;

public class Audio implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long id;
	private String audioKey;
	private int fileSize;
	private int audioSec;

	public static final String kAudioUrl = "url";
	public static final String kAudioKey = "key";
	public static final String kId = "id";
	public static final String kFileSize = "file_size";
	public static final String kAudioSec = "audio_sec";

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getAudioKey() {
		return audioKey;
	}

	public void setAudioKey(String audioKey) {
		this.audioKey = audioKey;
	}

	public int getFileSize() {
		return fileSize;
	}

	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}

	public int getAudioSec() {
		return audioSec;
	}

	public void setAudioSec(int audioSec) {
		this.audioSec = audioSec;
	}

	public String getAudioUrl() {
		return ServerConstant.QINiu_Host + this.audioKey;
	}

}
