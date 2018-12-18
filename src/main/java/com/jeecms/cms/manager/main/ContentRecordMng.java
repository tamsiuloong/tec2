package com.jeecms.cms.manager.main;

import com.jeecms.cms.entity.main.Content;
import com.jeecms.cms.entity.main.ContentRecord;
import com.jeecms.cms.entity.main.ContentRecord.ContentOperateType;
import com.jeecms.common.page.Pagination;
import com.jeecms.core.entity.CmsUser;

import java.util.List;

public interface ContentRecordMng {
	public Pagination getPage(int pageNo, int pageSize);
	
	public List<ContentRecord>getListByContentId(Integer contentId);
	
	public ContentRecord record(Content content, CmsUser user, ContentOperateType operate, Boolean isAuthorChange);

	public ContentRecord findById(Long id);

	public ContentRecord save(ContentRecord bean);

	public ContentRecord update(ContentRecord bean);

	public ContentRecord deleteById(Long id);
	
	public ContentRecord[] deleteByIds(Long[] ids);
}