package com.jeecms.cms.lucene;

import com.jeecms.common.web.freemarker.DirectiveUtils;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

import java.util.Date;
import java.util.Map;

public abstract class LuceneDirectiveAbstract implements TemplateDirectiveModel {
	/**
	 * 输入参数，搜索关键字
	 */
	public static final String PARAM_QUERY = "q";
	/**
	 * 输入参数，站点ID
	 */
	public static final String PARAM_SITE_ID = "siteId";
	/**
	 * 输入参数，栏目ID
	 */
	public static final String PARAM_CHANNEL_ID = "channelId";
	/**
	 * 输入参数，开始日期
	 */
	public static final String PARAM_START_DATE = "startDate";
	/**
	 * 输入参数，结束日期
	 */
	public static final String PARAM_END_DATE = "endDate";
	/**
	 * 输入参数，职位类型
	 */
	public static final String PARAM_CATEGORY = "category";

	/**
	 * 输入参数，部门id。可以为null。
	 */
	public static final String PARAM_DEPART_ID = "parentId";
	/**
	 * 输入参数，工作地点
	 */
	public static final String PARAM_WORKPLACE = "workplace";

	/**
	 * 0:parent为空  1:parent不为空
	 */
	public static final String PARAM_PARENT_TYPE = "parentType";
	public static final String PARAM_YEAR = "year";
	public static final String PARAM_PROJECT_TYPE = "projectType";
	public static final String PARAM_DEPT = "dept";

	protected String getQuery(Map<String, TemplateModel> params)
			throws TemplateException {
		return DirectiveUtils.getString(PARAM_QUERY, params);
	}

	protected Integer getSiteId(Map<String, TemplateModel> params)
			throws TemplateException {
		return DirectiveUtils.getInt(PARAM_SITE_ID, params);
	}

	protected Integer getChannelId(Map<String, TemplateModel> params)
			throws TemplateException {
		return DirectiveUtils.getInt(PARAM_CHANNEL_ID, params);
	}

	protected Date getStartDate(Map<String, TemplateModel> params)
			throws TemplateException {
		return DirectiveUtils.getDate(PARAM_START_DATE, params);
	}

	protected Date getEndDate(Map<String, TemplateModel> params)
			throws TemplateException {
		return DirectiveUtils.getDate(PARAM_END_DATE, params);
	}
	protected String getParentType(Map<String, TemplateModel> params)
			throws TemplateException {
		return DirectiveUtils.getString(PARAM_PARENT_TYPE, params);
	}

	protected String getYear(Map params)
			throws TemplateException {
		return DirectiveUtils.getString(PARAM_YEAR, params);
	}


	protected String getDept(Map params)
			throws TemplateException {
		return DirectiveUtils.getString(PARAM_DEPT, params);
	}


	protected String getProjectType(Map params)
			throws TemplateException {
		return DirectiveUtils.getString(PARAM_PROJECT_TYPE, params);
	}

	protected String getCategory(Map<String, TemplateModel> params)
			throws TemplateException {
		return DirectiveUtils.getString(PARAM_CATEGORY, params);
	}

	protected String getWorkplace(Map<String, TemplateModel> params)
			throws TemplateException {
		return DirectiveUtils.getString(PARAM_WORKPLACE, params);
	}

	protected String getDepartId(Map<String, TemplateModel> params)
			throws TemplateException {
		return DirectiveUtils.getString(PARAM_DEPART_ID, params);
	}

}
