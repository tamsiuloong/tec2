package com.jeecms.cms.api;

import com.alibaba.fastjson.JSON;
import com.jeecms.cms.entity.main.Maintenance;
import com.jeecms.cms.manager.main.MaintenanceMng;
import com.jeecms.cms.vo.ZtreeVO;
import com.jeecms.common.web.ResponseUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@Controller
public class MaintenanceApiAct {
	private static final Logger log = LoggerFactory.getLogger(MaintenanceApiAct.class);
	

	
	@RequestMapping(value = "/api/maintenance/v_tree.jspx")
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
		List<Maintenance> maintenanceList;
		maintenanceList= manager.getAll();
		List<ZtreeVO> ztreeVOList = new ArrayList<>(maintenanceList.size());
		for(Maintenance p:maintenanceList)
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
	



	@Autowired
	private MaintenanceMng manager;
}