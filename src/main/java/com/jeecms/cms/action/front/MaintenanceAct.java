package com.jeecms.cms.action.front;

import com.jeecms.cms.entity.main.Channel;
import com.jeecms.cms.entity.main.Content;
import com.jeecms.cms.entity.main.Maintenance;
import com.jeecms.cms.manager.main.ChannelMng;
import com.jeecms.cms.manager.main.ContentMng;
import com.jeecms.cms.manager.main.MaintenanceMng;
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
public class MaintenanceAct {

	public static final String MAINTENANCE = "tpl.maintenance";
	public static final String MAINTENANCE_INFO_LIST = "tpl.maintenanceInfoList";
	public static final String MAINTENANCE_INFO = "tpl.maintenanceInfo";
	/**
	 * 项目实施列表
	 * @param cid
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/*/maintenance.jspx", method = RequestMethod.GET)
	public String Project(Integer cid,HttpServletRequest request,
						HttpServletResponse response,
						ModelMap model) {
		CmsSite site = CmsUtils.getSite(request);
		FrontUtils.frontData(request, model, site);
		FrontUtils.frontPageData(request, model);
		Channel channel = channelMng.findById(cid);
		model.put("channel",channel);
		return FrontUtils.getTplPath(request, site.getSolutionPath(),
				TPLDIR_SPECIAL, MAINTENANCE);

	}

	/**
	 * 项目实施-项目内容列表
	 * @param id
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/*/maintenanceInfoList.jspx", method = RequestMethod.GET)
	public String infoList(Integer id,Integer typeId,Integer cid,HttpServletRequest request,
						HttpServletResponse response,
						ModelMap model) {
		// 全部？按站点？按栏目？要不同模板？
		CmsSite site = CmsUtils.getSite(request);
		FrontUtils.frontData(request, model, site);
		FrontUtils.frontPageData(request, model);
		model.putAll(RequestUtils.getQueryParams(request));

		model.addAttribute("typeId", typeId);

		Maintenance maintenanceCategory = maintenanceCategoryMng.findById(typeId);
		if(maintenanceCategory!=null)
		{
			model.addAttribute("pc", maintenanceCategory);
		}

		Content content = contentMng.findById(id);
		model.addAttribute("content", content);
		model.addAttribute("id", id);
		Channel channel = channelMng.findById(cid);
		model.addAttribute("channel", channel);
		return FrontUtils.getTplPath(request, site.getSolutionPath(),
				TPLDIR_SPECIAL, MAINTENANCE_INFO_LIST);

	}

	@RequestMapping(value = "/*/maintenanceInfo.jspx", method = RequestMethod.GET)
	public String maintenanceInfo(Integer id,Integer typeId,Integer cid,Integer parentId,HttpServletRequest request,
						   HttpServletResponse response,
						   ModelMap model) {
		// 全部？按站点？按栏目？要不同模板？
		CmsSite site = CmsUtils.getSite(request);
		FrontUtils.frontData(request, model, site);
		FrontUtils.frontPageData(request, model);
//		model.putAll(RequestUtils.getQueryParams(request));

		model.addAttribute("typeId", typeId);
		model.addAttribute("id", parentId);

		Maintenance maintenanceCategory = maintenanceCategoryMng.findById(typeId);
		if(maintenanceCategory!=null)
		{
			model.addAttribute("pc", maintenanceCategory);
		}
		Content parent = contentMng.findById(parentId);
		model.addAttribute("parent", parent);

		Content content = contentMng.findById(id);
		model.addAttribute("c", content);

		Channel channel = channelMng.findById(cid);
		model.addAttribute("channel", channel);

		return FrontUtils.getTplPath(request, site.getSolutionPath(),
				TPLDIR_SPECIAL, MAINTENANCE_INFO);

	}
	@Autowired
	private ChannelMng channelMng;
	@Autowired
	private ContentMng contentMng;

	@Autowired
	private MaintenanceMng maintenanceCategoryMng;

}
