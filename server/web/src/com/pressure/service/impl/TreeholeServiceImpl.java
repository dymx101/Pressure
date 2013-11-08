package com.pressure.service.impl;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pressure.mapper.TreeholeMapper;
import com.pressure.meta.Treehole;
import com.pressure.service.TreeholeService;

@Service("treeholeService")
public class TreeholeServiceImpl implements TreeholeService {
	@Resource
	private TreeholeMapper treeholeMapper;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.TreeholeService#addTreehole(long,
	 * java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public boolean addTreehole(long userId, String pictureUrl, String voice,
			String location, String content) {

		Treehole treehole = new Treehole();
		treehole.setUserId(userId);
		treehole.setPictureUrl(pictureUrl);
		treehole.setVoice(voice);
		treehole.setLocation(location);
		treehole.setContent(content);
		treehole.setCreateTime(new Date().getTime());
		treehole.setLastUpdateTime(new Date().getTime());

		if (treeholeMapper.addTreehole(treehole) > 0) {
			return true;
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.TreeholeService#updateTreehole(long,
	 * java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public boolean updateTreehole(long id, String pictureUrl, String voice,
			String location, String content) {
		long lastUpdateTime = new Date().getTime();
		if (treeholeMapper.updateTreehole(id, pictureUrl, voice, location,
				content, lastUpdateTime) > 0) {
			return true;
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.TreeholeService#buryTreehole(long, long)
	 */
	@Override
	public boolean buryTreehole(long id, long userId) {
		long LastUpdateTime = new Date().getTime();
		int status = Treehole.TreeholeStatus.Delete.getValue();
		if (treeholeMapper.buryTreehole(id, userId, LastUpdateTime, status) > 0) {
			return true;
		}
		return false;
	}
}
