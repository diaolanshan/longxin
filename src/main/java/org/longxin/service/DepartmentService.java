package org.longxin.service;

import java.util.List;

import org.longxin.domains.Department;

public interface DepartmentService
{
	public List<Department> getAllDepartments();

	public void deleteDepartmentByID(int departmentID);

	public void saveDepartment(Department department);
}
