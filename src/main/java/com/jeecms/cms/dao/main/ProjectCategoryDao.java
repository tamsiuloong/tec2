package com.jeecms.cms.dao.main;

import com.jeecms.cms.entity.main.ProjectCategory;

import java.util.List;

/**
 * Created by loong on 2017-03-30.
 */
public interface ProjectCategoryDao {
    ProjectCategory update(ProjectCategory bean);

    ProjectCategory save(ProjectCategory bean);

    List<ProjectCategory> getList(Integer pid);

    ProjectCategory findById(Integer id);

    ProjectCategory deleteById(Integer id);
}
