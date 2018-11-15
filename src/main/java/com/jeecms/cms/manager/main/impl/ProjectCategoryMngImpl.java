package com.jeecms.cms.manager.main.impl;

import com.jeecms.cms.dao.main.ProjectCategoryDao;
import com.jeecms.cms.entity.main.ProjectCategory;
import com.jeecms.cms.manager.main.ProjectCategoryMng;
import com.jeecms.core.entity.CmsDepartment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ProjectCategoryMngImpl implements ProjectCategoryMng {

	private ProjectCategoryDao dao;
	@Autowired
	public void setDao(ProjectCategoryDao dao) {
		this.dao = dao;
	}

	@Override
	public List<ProjectCategory> getList(String root) {
		Integer id = null;
		try{
			if(root!=null&&!root.equals("source"))
			{
				id = Integer.valueOf(root);
			}
		}catch(Exception e){

		}
		return dao.getList(id);
	}

	@Override
	public ProjectCategory findById(Integer id) {
		return dao.findById(id);
	}

	@Override
	public ProjectCategory save(ProjectCategory bean, Integer pid) {
		if(pid!=null){
			ProjectCategory parent = new ProjectCategory();
			parent.setId(pid);
			bean.setParent(parent);
		}

		return dao.save(bean);
	}

	@Override
	public ProjectCategory update(ProjectCategory bean) {
		return dao.update(bean);
	}

	@Override
	public ProjectCategory[] deleteByIds(Integer[] ids) {
		ProjectCategory[] result = new ProjectCategory[ids.length];
		for(int i = 0 ;i < ids.length;i++){
			result[i]=dao.deleteById(ids[i]);

		}
		return result;
	}

	@Override
	public List<CmsDepartment> getAll() {
		return dao.findAll();
	}
}