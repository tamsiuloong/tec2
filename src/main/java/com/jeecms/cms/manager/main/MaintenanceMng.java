package com.jeecms.cms.manager.main;

import com.jeecms.cms.entity.main.Maintenance;

import java.util.List;

/**
 * Created by loong on 2017-03-29.
 */
public interface MaintenanceMng {

    List<Maintenance> getList(String root);

    Maintenance findById(Integer id);

    Maintenance save(Maintenance bean, Integer pid);

    Maintenance update(Maintenance bean);

    Maintenance[] deleteByIds(Integer[] ids);

    List<Maintenance> getAll();
}
