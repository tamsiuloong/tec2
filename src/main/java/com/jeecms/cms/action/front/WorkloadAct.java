package com.jeecms.cms.action.front;

import com.jeecms.common.web.RequestUtils;
import com.jeecms.core.entity.CmsSite;
import com.jeecms.core.web.util.CmsUtils;
import com.jeecms.core.web.util.FrontUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.jeecms.cms.Constants.TPLDIR_SPECIAL;

/**
 * 工作量统计
 */
@Controller
public class WorkloadAct {

	public static final String MORE = "tpl.workloadMore";


	/**
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/workload/more.jspx", method = RequestMethod.GET)
	public String more(Integer departId,Integer cid,HttpServletRequest request,
						HttpServletResponse response,
						ModelMap model) {
		// 全部？按站点？按栏目？要不同模板？
		CmsSite site = CmsUtils.getSite(request);
		FrontUtils.frontData(request, model, site);
		FrontUtils.frontPageData(request, model);
		model.putAll(RequestUtils.getQueryParams(request));

		return FrontUtils.getTplPath(request, site.getSolutionPath(),
				TPLDIR_SPECIAL, MORE);

	}



}
