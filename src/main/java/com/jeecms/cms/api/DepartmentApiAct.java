package com.jeecms.cms.api;

import com.alibaba.fastjson.JSON;
import com.jeecms.cms.vo.ZtreeVO;
import com.jeecms.common.web.ResponseUtils;
import com.jeecms.core.entity.CmsDepartment;
import com.jeecms.core.manager.CmsDepartmentMng;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@Controller
public class DepartmentApiAct {
	private static final Logger log = LoggerFactory.getLogger(DepartmentApiAct.class);
	

	
	@RequestMapping(value = "/api/depart/v_tree.jspx")
	public void selectParent(String root, HttpServletRequest request,
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
		List<CmsDepartment> departmentList;
		departmentList= manager.getAll();
		List<ZtreeVO> ztreeVOList = new ArrayList<>(departmentList.size());
		for(CmsDepartment p:departmentList)
		{
			ZtreeVO ztreeVO = new ZtreeVO();
			ztreeVO.setId(p.getId().toString());
			ztreeVO.setName(p.getName());
			ztreeVO.setOpen(true);
			if(p.getParent()!=null)
			{
				ztreeVO.setPId(p.getParent().getId().toString());
			}
			else
			{
				ztreeVO.setPId("0");
			}


			ztreeVOList.add(ztreeVO);
		}

		String json = JSON.toJSONString(ztreeVOList);
		ResponseUtils.renderJson(response, json);
	}

	@RequestMapping(value = "/api/depart/workload.jspx")
	public void workload(@RequestParam(name = "pid",defaultValue = "1") Integer pid, @RequestParam(name = "pageSize",defaultValue = "10")Integer pageSize, HttpServletRequest request,
						 HttpServletResponse response, ModelMap model) {


		List result = manager.workload(pid,pageSize);

		String json = JSON.toJSONString(result);
		ResponseUtils.renderJson(response, json);

	}


	@Autowired
	private CmsDepartmentMng manager;
}