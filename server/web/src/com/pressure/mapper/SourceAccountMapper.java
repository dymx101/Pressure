package com.pressure.mapper;

import org.apache.ibatis.annotations.Param;
import com.pressure.meta.SourceAccount;

/**
 * 
 * @ClassName: SourceAccountMapper
 * @Description: TODO
 * @author yunshang_734@163.com
 * @date 2013-10-29 ����10:50:25
 */
public interface SourceAccountMapper {
	public int addSourceAccount(SourceAccount sourceAccount);

	public SourceAccount getSourceAccountByAccessUserId(
			@Param(value = "AccessUserId") long AccessUserId,
			@Param(value = "SourceType") int SourceType);
}
