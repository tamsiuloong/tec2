package com.jeecms.cms.action.front;

import com.jeecms.cms.entity.main.Channel;
import com.jeecms.cms.entity.main.ProjectCategory;
import com.jeecms.cms.manager.main.ChannelMng;
import com.jeecms.cms.manager.main.ProjectCategoryMng;
import com.jeecms.common.web.RequestUtils;
import com.jeecms.core.entity.CmsSite;
import com.jeecms.core.web.util.CmsUtils;
import com.jeecms.core.web.util.FrontUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.jeecms.cms.Constants.TPLDIR_SPECIAL;

/**
 * 项目资料
 */
@Controller
public class ProjectAct {

	public static final String IMPLEMENTATION = "tpl.project";
	public static final String PROJECT_INFO_LIST = "tpl.projectInfoList";
	/**
	 * 项目实施列表
	 * @param cid
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/*/project.jspx", method = RequestMethod.GET)
	public String Project(Integer cid,HttpServletRequest request,
						HttpServletResponse response,
						ModelMap model) {
		CmsSite site = CmsUtils.getSite(request);
		FrontUtils.frontData(request, model, site);
		FrontUtils.frontPageData(request, model);
		Channel channel = channelMng.findById(cid);
		model.put("channel",channel);
		return FrontUtils.getTplPath(request, site.getSolutionPath(),
				TPLDIR_SPECIAL, IMPLEMENTATION);

	}

	/**
	 * 项目实施-项目内容列表
	 * @param id
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/*/projectInfoList.jspx", method = RequestMethod.GET)
	public String infoList(Integer id,Integer typeId,HttpServletRequest request,
						HttpServletResponse response,
						ModelMap model) {
		// 全部？按站点？按栏目？要不同模板？
		CmsSite site = CmsUtils.getSite(request);
		FrontUtils.frontData(request, model, site);
		FrontUtils.frontPageData(request, model);
		model.putAll(RequestUtils.getQueryParams(request));

		model.addAttribute("typeId", typeId);

		ProjectCategory projectCategory = projectCategoryMng.findById(typeId);
		if(projectCategory!=null)
		{
			model.addAttribute("pc", projectCategory);
		}

		return FrontUtils.getTplPath(request, site.getSolutionPath(),
				TPLDIR_SPECIAL, PROJECT_INFO_LIST);

	}
	@Autowired
	private ChannelMng channelMng;

	@Autowired
	private ProjectCategoryMng projectCategoryMng;

}
