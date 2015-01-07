package org.longxin.service.impl;

import java.util.List;

import org.longxin.dao.DepartmentDAO;
import org.longxin.domains.Department;
import org.longxin.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;

public class DepartmentServiceImpl implements DepartmentService
{

	@Autowired
	DepartmentDAO departmentDAO;
	
	public List<Department> getAllDepartments()
	{
		return departmentDAO.getAllDepartments();
	}

	public void deleteDepartmentByID(int departmentID)
	{
		departmentDAO.deleteDepartmentByID(departmentID);
	}

	public void saveDepartment(Department department)
	{
		departmentDAO.saveDepartment(department);
	}

}
