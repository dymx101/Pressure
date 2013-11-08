package com.pressure.service;

/**
 * 
 * @ClassName: TreeholeService
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-11-7 下午10:53:40
 */
public interface TreeholeService {
	/**
	 * 添加树洞
	 * 
	 * @param userId
	 * @param pictureUrl
	 * @param voice
	 * @param location
	 * @param content
	 * @return
	 */
	public boolean addTreehole(long userId, String pictureUrl, String voice,
			String location, String content);

	/**
	 * 修改树洞
	 * 
	 * @param id
	 * @param userId
	 * @param pictureUrl
	 * @param voice
	 * @param location
	 * @param content
	 * @return
	 */
	public boolean updateTreehole(long id, String pictureUrl, String voice,
			String location, String content);

	/**
	 * 埋葬树洞
	 * 
	 * @param id
	 * @param userId
	 * @return
	 */
	public boolean buryTreehole(long id, long userId);
}
