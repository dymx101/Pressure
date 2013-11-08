package com.pressure.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pressure.meta.Treehole;

/**
 * 
 * @ClassName: TreeholeMapper
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-11-6 下午06:30:28
 */
public interface TreeholeMapper {

	/**
	 * 添加树洞
	 * 
	 * @param treehole
	 * @return
	 */
	public int addTreehole(Treehole treehole);

	/**
	 * 修改树洞
	 * 
	 * @param id
	 * @param pictureUrl
	 * @param voice
	 * @param location
	 * @param content
	 * @return
	 */
	public int updateTreehole(@Param(value = "Id") long id,
			@Param(value = "PictureUrl") String pictureUrl,
			@Param(value = "Voice") String voice,
			@Param(value = "Location") String location,
			@Param(value = "content") String content,
			@Param(value = "LastUpdateTime") long lastUpdateTime);

	/**
	 * 埋葬树洞
	 * 
	 * @param id
	 * @param userId
	 * @param lastUpdateTime
	 * @param status
	 * @return
	 */
	public int buryTreehole(@Param(value = "Id") long id,
			@Param(value = "UserId") long userId,
			@Param(value = "LastUpdateTime") long LastUpdateTime,
			@Param(value = "status") int status);

	/**
	 * 获取树洞列表
	 * 
	 * @param userId
	 * @param status
	 * @param limit
	 * @param offset
	 * @return
	 */
	public List<Treehole> getTreeholeList(@Param(value = "UserId") long userId,
			@Param(value = "status") int status,
			@Param(value = "limit") int limit,
			@Param(value = "offset") int offset);
}
