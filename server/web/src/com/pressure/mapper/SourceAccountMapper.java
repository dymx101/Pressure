package com.pressure.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.taglibs.standard.lang.jstl.test.beans.PublicBean1;

import com.pressure.meta.SourceAccount;

/**
 * 
 * @ClassName: SourceAccountMapper
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-29 ÏÂÎç10:50:25
 */
public interface SourceAccountMapper {
	public int addSourceAccount(@Param(value = "UserId") long UserId,
			@Param(value = "AccessUserId") long AccessUserId,
			@Param(value = "AccessUserName") String AccessUserName,
			@Param(value = "AccessToken") String AccessToken,
			@Param(value = "ExpiresIn") String ExpiresIn,
			@Param(value = "SourceType") int SourceType,
			@Param(value = "CreateTime)") long CreateTime);

	public SourceAccount getSourceAccountByUserId(
			@Param(value = "UserId") long UserId,
			@Param(value = "SourceType") int SourceType);
}
