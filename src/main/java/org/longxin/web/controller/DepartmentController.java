package org.longxin.web.controller;

import org.longxin.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("department")
public class DepartmentController
{
	@Autowired
	DepartmentService departmentService;
	
	
}
