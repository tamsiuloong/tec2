package com.jeecms.cms.dao.main;

import com.jeecms.cms.entity.main.Maintenance;

import java.util.List;

/**
 * Created by loong on 2017-03-30.
 */
public interface MaintenanceDao {
    Maintenance update(Maintenance bean);

    Maintenance save(Maintenance bean);

    List<Maintenance> getList(Integer pid);

    Maintenance findById(Integer id);

    Maintenance deleteById(Integer id);

    List<Maintenance> findAll();
}
