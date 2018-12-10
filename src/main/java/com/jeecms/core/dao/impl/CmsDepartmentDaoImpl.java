package com.jeecms.core.dao.impl;

import com.jeecms.common.hibernate4.Finder;
import com.jeecms.common.hibernate4.HibernateBaseDao;
import com.jeecms.common.page.Pagination;
import com.jeecms.core.dao.CmsDepartmentDao;
import com.jeecms.core.entity.CmsDepartment;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CmsDepartmentDaoImpl extends
		HibernateBaseDao<CmsDepartment, Integer> implements CmsDepartmentDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Override
	public List<CmsDepartment> getAll() {
		Finder f = Finder.create("from CmsDepartment bean");
		f.append(" order by bean.priority asc ");
		return find(f);
	}

	@SuppressWarnings("unchecked")
	public List<CmsDepartment> getList(Integer parentId,boolean all){
		Finder f = Finder.create("from CmsDepartment bean");
		if(!all){
			if(parentId!=null){
				f.append(" where bean.parent.id=:parentId").setParam("parentId", parentId);
			}else{
				f.append(" where bean.parent is null ");
			}
		}
		f.append(" order by bean.priority asc ");
		return find(f);
	}
	public Pagination getPage( String name, int pageNo,int pageSize) {
		Finder f = Finder.create("from CmsDepartment bean where 1=1");
		if (StringUtils.isNotBlank(name)) {
			f.append(" and bean.name like :name");
			f.setParam("name", "%" + name + "%");
		}
		f.append(" order by bean.priority asc,weights desc");
		return find(f, pageNo, pageSize);
	}
	

	public CmsDepartment findById(Integer id) {
		CmsDepartment entity = get(id);
		return entity;
	}

	@Override
	public List<CmsDepartment> findByParentId(int parentId, int pageSize) {
		Query query = getSession().createQuery("from CmsDepartment where parent.id = :parentId");
		query.setParameter("parentId",parentId);
		query.setFirstResult(0);
		query.setMaxResults(pageSize);
		return query.list();
	}

	@Override
	public Integer getWorkloadById(Integer id) {

		String sql = "SELECT\n" +
				"\tsum(q1.nums)\n" +
				"FROM\n" +
				"\t(\n" +
				"\t\tSELECT\n" +
				"\t\t\td1.depart_name ,\n" +
				"\t\t\tifnull(t.nums , 0) nums ,\n" +
				"\t\t\td1.depart_id\n" +
				"\t\tFROM\n" +
				"\t\t\tjc_department d1\n" +
				"\t\tLEFT JOIN(\n" +
				"\t\t\tSELECT\n" +
				"\t\t\t\td.depart_id ,\n" +
				"\t\t\t\tcount(c.user_id) nums\n" +
				"\t\t\tFROM\n" +
				"\t\t\t\tjc_content c\n" +
				"\t\t\tJOIN jc_user u ON c.user_id = u.user_id\n" +
				"\t\t\tJOIN jc_department d ON u.depart_id = d.depart_id\n" +
				"\t\t\tGROUP BY\n" +
				"\t\t\t\td.depart_id\n" +
				"\t\t) t ON d1.depart_id = t.depart_id\n" +
				"\t\tORDER BY\n" +
				"\t\t\tnums DESC\n" +
				"\t) q1\n" +
				"right JOIN(\n" +
				"\tSELECT\n" +
				"\t\tdepart_id\n" +
				"\tFROM\n" +
				"\t\t(\n" +
				"\t\t\tSELECT t1.depart_id ,\n" +
				"\t\t\tIF(\n" +
				"\t\t\t\tfind_in_set(parent_id , @pids) > 0 ,\n" +
				"\t\t\t\t@pids := concat(@pids , ',' , depart_id) ,\n" +
				"\t\t\t\t0\n" +
				"\t\t\t) AS ischild FROM(\n" +
				"\t\t\t\tSELECT t.depart_id ,\n" +
				"\t\t\t\tt.parent_id FROM jc_department t ORDER BY t.parent_id ,\n" +
				"\t\t\t\tt.depart_id\n" +
				"\t\t\t) t1 ,\n" +
				"\t\t\t(SELECT @pids := ?) t2 \n" +
				"\t\t) t3 WHERE ischild != 0 or depart_id=?\n" +
				") q2 ON q1.depart_id = q2.depart_id ";

		Integer result = jdbcTemplate.queryForObject(sql,new Object[]{id,id}, Integer.class);

//		SQLQuery sqlQuery = getSession().createSQLQuery("SELECT\n" +
//				"\tsum(q1.nums)\n" +
//				"FROM\n" +
//				"\t(\n" +
//				"\t\tSELECT\n" +
//				"\t\t\td1.depart_name ,\n" +
//				"\t\t\tifnull(t.nums , 0) nums ,\n" +
//				"\t\t\td1.depart_id\n" +
//				"\t\tFROM\n" +
//				"\t\t\tjc_department d1\n" +
//				"\t\tLEFT JOIN(\n" +
//				"\t\t\tSELECT\n" +
//				"\t\t\t\td.depart_id ,\n" +
//				"\t\t\t\tcount(c.user_id) nums\n" +
//				"\t\t\tFROM\n" +
//				"\t\t\t\tjc_content c\n" +
//				"\t\t\tJOIN jc_user u ON c.user_id = u.user_id\n" +
//				"\t\t\tJOIN jc_department d ON u.depart_id = d.depart_id\n" +
//				"\t\t\tGROUP BY\n" +
//				"\t\t\t\td.depart_id\n" +
//				"\t\t) t ON d1.depart_id = t.depart_id\n" +
//				"\t\tORDER BY\n" +
//				"\t\t\tnums DESC\n" +
//				"\t) q1\n" +
//				"right JOIN(\n" +
//				"\tSELECT\n" +
//				"\t\tdepart_id\n" +
//				"\tFROM\n" +
//				"\t\t(\n" +
//				"\t\t\tSELECT t1.depart_id ,\n" +
//				"\t\t\tIF(\n" +
//				"\t\t\t\tfind_in_set(parent_id , @pids) > 0 ,\n" +
//				"\t\t\t\t@pids := concat(@pids , ',' , depart_id) ,\n" +
//				"\t\t\t\t0\n" +
//				"\t\t\t) AS ischild FROM(\n" +
//				"\t\t\t\tSELECT t.depart_id ,\n" +
//				"\t\t\t\tt.parent_id FROM jc_department t ORDER BY t.parent_id ,\n" +
//				"\t\t\t\tt.depart_id\n" +
//				"\t\t\t) t1 ,\n" +
//				"\t\t\t(SELECT @pids := :parentId) t2\n" +
//				"\t\t) t3 WHERE ischild != 0\n" +
//				") q2 ON q1.depart_id = q2.depart_id ");

//		sqlQuery.setParameter("parentId",id);
		return result;
	}

	@Override
	public List workload() {
		List result = null;
		SQLQuery sqlQuery = getSession().createSQLQuery("SELECT\n" +
				"\td1.depart_name ,\n" +
				"\tifnull(t.nums,0),d1.depart_id\n" +
				"FROM\n" +
				"\tjc_department d1\n" +
				"LEFT JOIN(\n" +
				"\tSELECT\n" +
				"\t\td.depart_id ,\n" +
				"\t\tcount(c.user_id) nums\n" +
				"\tFROM\n" +
				"\t\tjc_content c\n" +
				"\tJOIN jc_user u ON c.user_id = u.user_id\n" +
				"\tJOIN jc_department d ON u.depart_id = d.depart_id\n" +
				"\tGROUP BY\n" +
				"\t\td.depart_id\n" +
				") t ON d1.depart_id = t.depart_id\n" +
				"ORDER BY\n" +
				"\tnums DESC\n");
		sqlQuery.setFirstResult(0);
		sqlQuery.setMaxResults(10);
		result = sqlQuery.list();
		return result;
	}

	public CmsDepartment findByName(String name) {
		return findUniqueByProperty("name", name);
	}

	public CmsDepartment save(CmsDepartment bean) {
		getSession().save(bean);
		return bean;
	}


	public CmsDepartment deleteById(Integer id) {
		CmsDepartment entity = super.get(id);
		if (entity != null) {
			getSession().delete(entity);
		}
		return entity;
	}

	protected Class<CmsDepartment> getEntityClass() {
		return CmsDepartment.class;
	}


}