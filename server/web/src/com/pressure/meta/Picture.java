package com.pressure.meta;

import java.io.Serializable;

import com.pressure.constant.ServerConstant;

public class Picture implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long id;
	private String pictureKey;
	private int fileSize;
	private int width;
	private int height;

	public static final String kID = "id";
	public static final String kPictureKey = "key";
	public static final String kPictureUrl = "url";
	public static final String kFileSize = "file_size";
	public static final String kWidth = "width";
	public static final String kHeight = "height";

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getPictureKey() {
		return pictureKey;
	}

	public void setPictureKey(String pictureKey) {
		this.pictureKey = pictureKey;
	}

	public int getFileSize() {
		return fileSize;
	}

	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}

	public int getWidth() {
		return width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public String getPictureUrl() {
		return ServerConstant.QINiu_Host + this.pictureKey;
	}
}
