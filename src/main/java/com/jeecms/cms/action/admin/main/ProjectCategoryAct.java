package com.jeecms.cms.action.admin.main;

import com.jeecms.cms.entity.main.Content;
import com.jeecms.cms.entity.main.ProjectCategory;
import com.jeecms.cms.manager.main.ProjectCategoryMng;
import com.jeecms.core.entity.CmsDepartment;
import com.jeecms.core.entity.CmsUser;
import com.jeecms.core.manager.CmsLogMng;
import com.jeecms.core.web.WebCoreErrors;
import com.jeecms.core.web.util.CmsUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
public class ProjectCategoryAct {
	private static final Logger log = LoggerFactory.getLogger(ProjectCategoryAct.class);
	
	@RequiresPermissions("projectCategory:projectCategory_main")
	@RequestMapping("/projectCategory/projectCategory_main.do")
	public String projectCategoryMain(ModelMap model) {
		return "projectCategory/projectCategory_main";
	}
	
	@RequiresPermissions("projectCategory:v_left")
	@RequestMapping("/projectCategory/v_left.do")
	public String left() {
		return "projectcategory/left";
	}
	
	@RequiresPermissions("projectCategory:v_tree")
	@RequestMapping(value = "/projectCategory/v_tree.do")
	public String selectParent(String root, HttpServletRequest request,
                               HttpServletResponse response, ModelMap model) {
		log.debug("tree path={}", root);
		boolean isRoot;
		// jquery treeview的根请求为root=source
		if (StringUtils.isBlank(root) || "source".equals(root)) {
			isRoot = true;
		} else {
			isRoot = false;
		}
		model.addAttribute("isRoot", isRoot);
		List<ProjectCategory> projectCategoryList;
		projectCategoryList= manager.getList(root);
		
		model.addAttribute("list", projectCategoryList);
		response.setHeader("Cache-Control", "no-cache");
		response.setContentType("text/json;charset=UTF-8");
		return "projectcategory/tree";
	}
	
	@RequiresPermissions("projectCategory:v_list")
	@RequestMapping("/projectCategory/v_list.do")
	public String list(HttpServletRequest request,
                       ModelMap model, String root) {
		List<ProjectCategory> list;
		list = manager.getList(root);
		model.addAttribute("list", list);
		model.addAttribute("root", root);
		return "projectcategory/list";
	}

	@RequiresPermissions("projectCategory:v_add")
	@RequestMapping("/projectCategory/v_add.do")
	public String add(Integer root,ModelMap model) {
		ProjectCategory projectCategory =null;
		if(root!=null){
			projectCategory= manager.findById(root);

		}else {
			 projectCategory = new ProjectCategory();
			ProjectCategory parent = new ProjectCategory();
			projectCategory.setParent(parent);
		}
		model.addAttribute("projectCategory", projectCategory);
		model.addAttribute("root", root);
		return "projectcategory/add";
	}

	@RequiresPermissions("projectCategory:v_edit")
	@RequestMapping("/projectCategory/v_edit.do")
	public String edit(Integer id, HttpServletRequest request, ModelMap model) {
		WebCoreErrors errors = validateEdit(id, request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		model.addAttribute("projectCategory", manager.findById(id));
		return "projectcategory/edit";
	}

	@RequiresPermissions("projectCategory:o_save")
	@RequestMapping("/projectCategory/o_save.do")
	public String save(ProjectCategory bean, Integer pid,
                       HttpServletRequest request, ModelMap model) throws IOException {
		CmsUser user = CmsUtils.getUser(request);
		WebCoreErrors errors = validateSave(bean, null, request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		bean = manager.save(bean,pid );
		log.info("save ProjectCategory id={}", bean.getId());
		cmsLogMng.operating(request, "projectCategory.log.save", "id=" + bean.getId()
				+ ";name=" + bean.getName());
		return "redirect:v_list.do?root="+(pid==null?"":pid);
	}



	@RequiresPermissions("projectCategory:o_update")
	@RequestMapping("/projectCategory/o_update.do")
	public String update(ProjectCategory bean, Integer uploadFtpId,
                         Integer syncPageFtpId, Integer pageNo,
                         HttpServletRequest request, ModelMap model) {
		WebCoreErrors errors = validateUpdate(bean.getId(), uploadFtpId, request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		ProjectCategory jobCategory = manager.findById(bean.getId());
		jobCategory.setName(bean.getName());
		bean = manager.update(jobCategory);
		log.info("update ProjectCategory id={}.", bean.getId());
		cmsLogMng.operating(request, "projectCategory.log.update", "id=" + bean.getId()
				+ ";name=" + bean.getName());
		return list(request, model, null);
	}

	@RequiresPermissions("projectCategory:o_delete")
	@RequestMapping("/projectCategory/o_delete.do")
	public String delete(Integer[] ids, Integer pageNo,
                         HttpServletRequest request, ModelMap model) {
		WebCoreErrors errors = validateDelete(ids, request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		ProjectCategory[] beans = manager.deleteByIds(ids);
		for (ProjectCategory bean : beans) {
			log.info("delete ProjectCategory id={}", bean.getId());
			cmsLogMng.operating(request, "projectCategory.log.delete", "id="
					+ bean.getId() + ";name=" + bean.getName());
		}
		return list(request, model, null);
	}


	private WebCoreErrors validateSave(ProjectCategory bean, Integer uploadFtpId,
                                       HttpServletRequest request) {
		WebCoreErrors errors = WebCoreErrors.create(request);

		return errors;
	}

	private WebCoreErrors validateEdit(Integer id, HttpServletRequest request) {
		WebCoreErrors errors = WebCoreErrors.create(request);
		if (vldExist(id, errors)) {
			return errors;
		}
		return errors;
	}

	private WebCoreErrors validateUpdate(Integer id, Integer uploadFtpId,
                                         HttpServletRequest request) {
		WebCoreErrors errors = WebCoreErrors.create(request);
		if (vldExist(id, errors)) {
			return errors;
		}
		return errors;
	}

	private WebCoreErrors validateDelete(Integer[] ids, HttpServletRequest request) {
		WebCoreErrors errors = WebCoreErrors.create(request);
		errors.ifEmpty(ids, "ids");
		for (Integer id : ids) {
			vldExist(id, errors);
		}
		return errors;
	}



	private boolean vldExist(Integer id, WebCoreErrors errors) {
		if (errors.ifNull(id, "id")) {
			return true;
		}
		ProjectCategory entity = manager.findById(id);
		if (errors.ifNotExist(entity, ProjectCategory.class, id)) {
			return true;
		}
		return false;
	}

	@Autowired
	private CmsLogMng cmsLogMng;
	@Autowired
	private ProjectCategoryMng manager;
}