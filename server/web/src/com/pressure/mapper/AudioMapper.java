package com.pressure.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pressure.meta.Audio;
import com.pressure.meta.Picture;

public interface AudioMapper {
	/**
	 * 添加声音
	 * 
	 * @param audio
	 * @return
	 */
	public int addAudio(Audio audio);

	/**
	 * 获取声音
	 * 
	 * @param id
	 * @return
	 */
	public Audio getAudioById(@Param(value = "id") long id);

	/**
	 * 取声音列表
	 * 
	 * @param ids
	 * @return
	 */
	public List<Audio> getAudiosByIds(@Param(value = "ids") List<Long> ids);
}
