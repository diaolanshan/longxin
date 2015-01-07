package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.DepartmentDAO;
import org.longxin.domains.Department;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class DepartmentDAOImpl extends HibernateDaoSupport implements DepartmentDAO
{
	@SuppressWarnings("unchecked")
	public List<Department> getAllDepartments()
	{
		return this.getHibernateTemplate().find("FROM Department");
	}

	public void deleteDepartmentByID(int departmentID)
	{
		Department department = this.getDepartmentByID(departmentID);
		this.getHibernateTemplate().delete(department);
	}
	
	private Department getDepartmentByID(int departmentID)
	{
		return this.getHibernateTemplate().load(Department.class, departmentID);
	}

	public void saveDepartment(Department department)
	{
		this.getHibernateTemplate().saveOrUpdate(department);
	}
}
