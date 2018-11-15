package com.jeecms.cms.manager.main;

import com.jeecms.cms.entity.main.ProjectCategory;
import com.jeecms.core.entity.CmsDepartment;

import java.util.List;

/**
 * Created by loong on 2017-03-29.
 */
public interface ProjectCategoryMng {

    List<ProjectCategory> getList(String root);

    ProjectCategory findById(Integer id);

    ProjectCategory save(ProjectCategory bean, Integer pid);

    ProjectCategory update(ProjectCategory bean);

    ProjectCategory[] deleteByIds(Integer[] ids);

    List<CmsDepartment> getAll();
}
