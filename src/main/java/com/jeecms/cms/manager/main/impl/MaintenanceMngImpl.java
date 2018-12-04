package com.jeecms.cms.manager.main.impl;

import com.jeecms.cms.dao.main.MaintenanceDao;
import com.jeecms.cms.entity.main.Maintenance;
import com.jeecms.cms.manager.main.MaintenanceMng;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class MaintenanceMngImpl implements MaintenanceMng {

	private MaintenanceDao dao;
	@Autowired
	public void setDao(MaintenanceDao dao) {
		this.dao = dao;
	}

	@Override
	public List<Maintenance> getList(String root) {
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
	public Maintenance findById(Integer id) {
		return dao.findById(id);
	}

	@Override
	public Maintenance save(Maintenance bean, Integer pid) {
		if(pid!=null){
			Maintenance parent = new Maintenance();
			parent.setId(pid);
			bean.setParent(parent);
		}

		return dao.save(bean);
	}

	@Override
	public Maintenance update(Maintenance bean) {
		return dao.update(bean);
	}

	@Override
	public Maintenance[] deleteByIds(Integer[] ids) {
		Maintenance[] result = new Maintenance[ids.length];
		for(int i = 0 ;i < ids.length;i++){
			result[i]=dao.deleteById(ids[i]);

		}
		return result;
	}

	@Override
	public List<Maintenance> getAll() {
		return dao.findAll();
	}
}