package com.pressure.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pressure.meta.Picture;

public interface PictureMapper {
	/**
	 * 添加图片
	 * 
	 * @param picture
	 * @return
	 */
	public int addPicture(Picture picture);

	/**
	 * 获取图片
	 * 
	 * @param id
	 * @return
	 */
	public Picture getPictureById(@Param(value = "id") long id);

	/**
	 * 取列表
	 * 
	 * @param ids
	 * @return
	 */
	public List<Picture> getPicturesByIds(@Param(value = "ids") List<Long> ids);
}
