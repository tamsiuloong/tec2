package com.jeecms.cms.action.front;

import com.jeecms.cms.entity.main.Channel;
import com.jeecms.cms.entity.main.CmsTopic;
import com.jeecms.cms.entity.main.ProjectCategory;
import com.jeecms.cms.manager.main.ChannelMng;
import com.jeecms.cms.manager.main.CmsTopicMng;
import com.jeecms.cms.manager.main.ProjectCategoryMng;
import com.jeecms.core.entity.CmsSite;
import com.jeecms.core.web.util.CmsUtils;
import com.jeecms.core.web.util.FrontUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.jeecms.cms.Constants.TPLDIR_SPECIAL;
import static com.jeecms.cms.Constants.TPLDIR_TOPIC;

/**
 * 项目资料
 */
@Controller
public class ProjectInfoAct {

	public static final String PROJECT_INFO_LIST = "tpl.projectInfoList";

//	@RequestMapping(value = "/projectInfoList.jspx", method = RequestMethod.GET)
//	public String index(Integer typeId,
//			HttpServletRequest request, HttpServletResponse response,
//			ModelMap model) {
//		// 全部？按站点？按栏目？要不同模板？
//		CmsSite site = CmsUtils.getSite(request);
//		FrontUtils.frontData(request, model, site);
//		FrontUtils.frontPageData(request, model);
//		model.addAttribute("typeId", typeId);
//		ProjectCategory projectCategory = projectCategoryMng.findById(typeId);
//		model.addAttribute("pc", projectCategory);
//		return FrontUtils.getTplPath(request, site.getSolutionPath(),
//				TPLDIR_SPECIAL, PROJECT_INFO_LIST);
//
//	}

	@Autowired
	private ProjectCategoryMng projectCategoryMng;

}
