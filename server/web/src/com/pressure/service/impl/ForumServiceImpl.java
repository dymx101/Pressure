package com.pressure.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.pressure.mapper.AudioMapper;
import com.pressure.mapper.ForumMapper;
import com.pressure.mapper.PictureMapper;
import com.pressure.mapper.ProfileMapper;
import com.pressure.meta.Audio;
import com.pressure.meta.Forum;
import com.pressure.meta.Picture;
import com.pressure.meta.Profile;
import com.pressure.service.ForumService;
import com.pressure.util.HashMapMaker;
import com.pressure.util.ListUtils;

@Service("forumService")
public class ForumServiceImpl implements ForumService {

	@Resource
	private ForumMapper forumMapper;

	@Resource
	private PictureMapper pictureMapper;

	@Resource
	private ProfileMapper profileMapper;

	@Resource
	private AudioMapper audioMapper;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.ForumService#getForumsByTime(long, int)
	 */
	@Override
	public List<Forum> getForumsByTime(long beginTime, int limit) {
		List<Forum> forumList = forumMapper
				.getForumListByTime(beginTime, limit);
		if (ListUtils.isEmptyList(forumList)) {
			return null;
		}
		List<Long> ids = new ArrayList<Long>(forumList.size());
		List<Long> userIds = new ArrayList<Long>(forumList.size());
		for (Forum forum : forumList) {
			ids.add(forum.getId());
			userIds.add(forum.getUserId());
		}
		List<Picture> pictures = pictureMapper.getPicturesByIds(ids);
		List<Audio> audios = audioMapper.getAudiosByIds(ids);
		List<Profile> profiles = null;
		if (!ListUtils.isEmptyList(userIds)) {
			profiles = profileMapper.getProfilesByUserIdsOrderTime(userIds, -1,
					Integer.MAX_VALUE, -1);
		}

		Map<Long, Picture> pictureMap = HashMapMaker.listToMap(pictures,
				"getId", Picture.class);
		Map<Long, Audio> audioMap = HashMapMaker.listToMap(audios, "getId",
				Audio.class);
		Map<Long, Profile> profileMap = HashMapMaker.listToMap(profiles,
				"getUserId", Profile.class);
		for (Forum forum : forumList) {
			Picture picture = pictureMap.get(forum.getPictureId());
			if (picture != null) {
				forum.setPicture(picture);
			}
			Audio audio = audioMap.get(forum.getAudioId());
			if (audio != null) {
				forum.setAudio(audio);
			}
			Profile profile = profileMap.get(forum.getUserId());
			if (profile != null) {
				forum.setProfile(profile);
			}
		}
		return forumList;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.ForumService#addForum(java.lang.String,
	 * java.lang.String, java.lang.String, long, int)
	 */
	@Override
	public Forum addForum(String text, Audio audio, Picture picture,
			long userId, int chatType) {
		if (audio != null && !StringUtils.isEmpty(audio.getAudioKey())) {
			audioMapper.addAudio(audio);
		}
		if (picture != null && !StringUtils.isEmpty(picture.getPictureKey())) {
			pictureMapper.addPicture(picture);
		}

		Forum forum = new Forum();
		forum.setText(text);
		forum.setPrefix("");
		forum.setAudioId(audio.getId());
		forum.setPictureId(picture.getId());
		forum.setUserId(userId);
		forum.setChatType(chatType);
		if (forumMapper.addForum(forum) > 0) {
			return forum;
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.pressure.service.ForumService#getForumById(long)
	 */
	@Override
	public Forum getForumById(long id) {
		return forumMapper.getForumById(id);
	}

}
