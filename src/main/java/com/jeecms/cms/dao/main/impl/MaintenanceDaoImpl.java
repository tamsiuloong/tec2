package com.jeecms.cms.dao.main.impl;

import com.jeecms.cms.dao.main.MaintenanceDao;
import com.jeecms.cms.entity.main.Maintenance;
import com.jeecms.common.hibernate4.Finder;
import com.jeecms.common.hibernate4.HibernateBaseDao;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MaintenanceDaoImpl extends HibernateBaseDao<Maintenance, Integer>
		implements MaintenanceDao {
	@SuppressWarnings("unchecked")
	public List<Maintenance> getList(boolean containDisabled) {
		Finder f = Finder.create("from Maintenance bean");

		f.append(" order by bean.id asc");
		return find(f);
	}



	public Maintenance findById(Integer id) {
		Maintenance entity = get(id);
		return entity;
	}

	@Override
	public Maintenance update(Maintenance bean) {
		getSession().merge(bean);
		return bean;
	}


	public Maintenance save(Maintenance bean) {
		getSession().save(bean);
		return bean;
	}

	@Override
	public List<Maintenance> getList(Integer pid) {
		Finder f = Finder.create("from Maintenance bean where 1 = 1 ");
		if(pid!=null&&!pid.equals(0)){
			f.append(" and bean.parent.id=:pid");
			f.setParam("pid",pid);
		}else{
			f.append(" and bean.parent is null");
		}
		f.append(" order by bean.id asc");
		return find(f);
	}

	public Maintenance deleteById(Integer id) {
		Maintenance entity = super.get(id);
		if (entity != null) {
			getSession().delete(entity);
		}
		return entity;
	}

	@Override
	public List<Maintenance> findAll() {
		Finder f = Finder.create("from Maintenance bean");
		return find(f);
	}

	@Override
	protected Class<Maintenance> getEntityClass() {
		return Maintenance.class;
	}
}