package com.jeecms.cms.dao.main.impl;

import com.jeecms.cms.dao.main.ProjectCategoryDao;
import com.jeecms.cms.entity.main.ProjectCategory;
import com.jeecms.common.hibernate4.Finder;
import com.jeecms.common.hibernate4.HibernateBaseDao;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProjectCategoryDaoImpl extends HibernateBaseDao<ProjectCategory, Integer>
		implements ProjectCategoryDao {
	@SuppressWarnings("unchecked")
	public List<ProjectCategory> getList(boolean containDisabled) {
		Finder f = Finder.create("from ProjectCategory bean");

		f.append(" order by bean.id asc");
		return find(f);
	}



	public ProjectCategory findById(Integer id) {
		ProjectCategory entity = get(id);
		return entity;
	}

	@Override
	public ProjectCategory update(ProjectCategory bean) {
		getSession().merge(bean);
		return bean;
	}


	public ProjectCategory save(ProjectCategory bean) {
		getSession().save(bean);
		return bean;
	}

	@Override
	public List<ProjectCategory> getList(Integer pid) {
		Finder f = Finder.create("from ProjectCategory bean where 1 = 1 ");
		if(pid!=null&&!pid.equals(0)){
			f.append(" and bean.parent.id=:pid");
			f.setParam("pid",pid);
		}else{
			f.append(" and bean.parent is null");
		}
		f.append(" order by bean.id asc");
		return find(f);
	}

	public ProjectCategory deleteById(Integer id) {
		ProjectCategory entity = super.get(id);
		if (entity != null) {
			getSession().delete(entity);
		}
		return entity;
	}

	@Override
	protected Class<ProjectCategory> getEntityClass() {
		return ProjectCategory.class;
	}
}