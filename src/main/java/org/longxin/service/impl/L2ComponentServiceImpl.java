package org.longxin.service.impl;

import org.longxin.dao.L2ComponentDAO;
import org.longxin.domains.L2Component;
import org.longxin.service.L2ComponentService;
import org.springframework.beans.factory.annotation.Autowired;

public class L2ComponentServiceImpl implements L2ComponentService
{
	@Autowired
	L2ComponentDAO l2ComponentDAO;
	
	public L2Component getL2ComponentByID(Integer ID)
	{
		return l2ComponentDAO.getL2ComponentByID(ID);
	}
}
