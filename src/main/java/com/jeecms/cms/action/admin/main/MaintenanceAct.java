package com.jeecms.cms.action.admin.main;

import com.jeecms.cms.entity.main.Maintenance;
import com.jeecms.cms.manager.main.MaintenanceMng;
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
import java.util.List;

@Controller
public class MaintenanceAct {
	private static final Logger log = LoggerFactory.getLogger(MaintenanceAct.class);
	
	@RequiresPermissions("maintenance:maintenance_main")
	@RequestMapping("/maintenance/maintenance_main.do")
	public String maintenanceMain(ModelMap model) {
		return "maintenance/maintenance_main";
	}
	
	@RequiresPermissions("maintenance:v_left")
	@RequestMapping("/maintenance/v_left.do")
	public String left() {
		return "maintenance/left";
	}
	
	@RequiresPermissions("maintenance:v_tree")
	@RequestMapping(value = "/maintenance/v_tree.do")
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
		List<Maintenance> maintenanceList;
		maintenanceList= manager.getList(root);
		
		model.addAttribute("list", maintenanceList);
		response.setHeader("Cache-Control", "no-cache");
		response.setContentType("text/json;charset=UTF-8");
		return "maintenance/tree";
	}
	
	@RequiresPermissions("maintenance:v_list")
	@RequestMapping("/maintenance/v_list.do")
	public String list(HttpServletRequest request,
                       ModelMap model, String root) {
		List<Maintenance> list;
		list = manager.getList(root);
		model.addAttribute("list", list);
		model.addAttribute("root", root);
		return "maintenance/list";
	}

	@RequiresPermissions("maintenance:v_add")
	@RequestMapping("/maintenance/v_add.do")
	public String add(Integer root,ModelMap model) {
		Maintenance maintenance =null;
		if(root!=null){
			maintenance= manager.findById(root);

		}else {
			 maintenance = new Maintenance();
			Maintenance parent = new Maintenance();
			maintenance.setParent(parent);
		}
		model.addAttribute("maintenance", maintenance);
		model.addAttribute("root", root);
		return "maintenance/add";
	}

	@RequiresPermissions("maintenance:v_edit")
	@RequestMapping("/maintenance/v_edit.do")
	public String edit(Integer id, HttpServletRequest request, ModelMap model) {
		WebCoreErrors errors = validateEdit(id, request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		model.addAttribute("maintenance", manager.findById(id));
		return "maintenance/edit";
	}

	@RequiresPermissions("maintenance:o_save")
	@RequestMapping("/maintenance/o_save.do")
	public String save(Maintenance bean, Integer pid,
                       HttpServletRequest request, ModelMap model) throws IOException {
		CmsUser user = CmsUtils.getUser(request);
		WebCoreErrors errors = validateSave(bean, null, request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		bean = manager.save(bean,pid );
		log.info("save Maintenance id={}", bean.getId());
		cmsLogMng.operating(request, "maintenance.log.save", "id=" + bean.getId()
				+ ";name=" + bean.getName());
		return "redirect:v_list.do?root="+(pid==null?"":pid);
	}



	@RequiresPermissions("maintenance:o_update")
	@RequestMapping("/maintenance/o_update.do")
	public String update(Maintenance bean, Integer uploadFtpId,
                         Integer syncPageFtpId, Integer pageNo,
                         HttpServletRequest request, ModelMap model) {
		WebCoreErrors errors = validateUpdate(bean.getId(), uploadFtpId, request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		Maintenance jobCategory = manager.findById(bean.getId());
		jobCategory.setName(bean.getName());
		bean = manager.update(jobCategory);
		log.info("update Maintenance id={}.", bean.getId());
		cmsLogMng.operating(request, "maintenance.log.update", "id=" + bean.getId()
				+ ";name=" + bean.getName());
		return list(request, model, null);
	}

	@RequiresPermissions("maintenance:o_delete")
	@RequestMapping("/maintenance/o_delete.do")
	public String delete(Integer[] ids, Integer pageNo,
                         HttpServletRequest request, ModelMap model) {
		WebCoreErrors errors = validateDelete(ids, request);
		if (errors.hasErrors()) {
			return errors.showErrorPage(model);
		}
		Maintenance[] beans = manager.deleteByIds(ids);
		for (Maintenance bean : beans) {
			log.info("delete Maintenance id={}", bean.getId());
			cmsLogMng.operating(request, "maintenance.log.delete", "id="
					+ bean.getId() + ";name=" + bean.getName());
		}
		return list(request, model, null);
	}


	private WebCoreErrors validateSave(Maintenance bean, Integer uploadFtpId,
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
		Maintenance entity = manager.findById(id);
		if (errors.ifNotExist(entity, Maintenance.class, id)) {
			return true;
		}
		return false;
	}

	@Autowired
	private CmsLogMng cmsLogMng;
	@Autowired
	private MaintenanceMng manager;
}