package com.pressure.meta;

import java.io.Serializable;

public class ChatType implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private long id;

	private String name;

	public static final String kChatType_Id = "id";
	public static final String kChatType_Name = "name";

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
