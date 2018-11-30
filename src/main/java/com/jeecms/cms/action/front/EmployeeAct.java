package com.jeecms.cms.action.front;

import com.jeecms.cms.entity.main.Channel;
import com.jeecms.cms.entity.main.Content;
import com.jeecms.cms.entity.main.ProjectCategory;
import com.jeecms.cms.manager.main.ChannelMng;
import com.jeecms.cms.manager.main.ContentMng;
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
 * 资料
 */
@Controller
public class EmployeeAct {

	public static final String EMPLOYEE_INFO_LIST = "tpl.employeeInfoList";
	public static final String EMPLOYEE_INFO = "tpl.employeeInfo";
	

	/**
	 * 项目实施-项目内容列表
	 * @param departId
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/*/employeeInfoList.jspx", method = RequestMethod.GET)
	public String infoList(Integer departId,Integer cid,HttpServletRequest request,
						HttpServletResponse response,
						ModelMap model) {
		// 全部？按站点？按栏目？要不同模板？
		CmsSite site = CmsUtils.getSite(request);
		FrontUtils.frontData(request, model, site);
		FrontUtils.frontPageData(request, model);
		model.putAll(RequestUtils.getQueryParams(request));

		model.addAttribute("departId", departId);
		Channel channel = channelMng.findById(cid);
		model.addAttribute("channel", channel);

		return FrontUtils.getTplPath(request, site.getSolutionPath(),
				TPLDIR_SPECIAL, EMPLOYEE_INFO_LIST);

	}

	@RequestMapping(value = "/*/employeeInfo.jspx", method = RequestMethod.GET)
	public String employeeInfo(Integer id,Integer typeId,Integer cid,Integer parentId,HttpServletRequest request,
						   HttpServletResponse response,
						   ModelMap model) {
		// 全部？按站点？按栏目？要不同模板？
		CmsSite site = CmsUtils.getSite(request);
		FrontUtils.frontData(request, model, site);
		FrontUtils.frontPageData(request, model);
//		model.putAll(RequestUtils.getQueryParams(request));

		model.addAttribute("typeId", typeId);
		model.addAttribute("id", parentId);

		ProjectCategory employeeCategory = employeeCategoryMng.findById(typeId);
		if(employeeCategory!=null)
		{
			model.addAttribute("pc", employeeCategory);
		}
		Content parent = contentMng.findById(parentId);
		model.addAttribute("parent", parent);

		Content content = contentMng.findById(id);
		model.addAttribute("c", content);

		Channel channel = channelMng.findById(cid);
		model.addAttribute("channel", channel);

		return FrontUtils.getTplPath(request, site.getSolutionPath(),
				TPLDIR_SPECIAL, EMPLOYEE_INFO);

	}
	@Autowired
	private ChannelMng channelMng;
	@Autowired
	private ContentMng contentMng;

	@Autowired
	private ProjectCategoryMng employeeCategoryMng;

}
