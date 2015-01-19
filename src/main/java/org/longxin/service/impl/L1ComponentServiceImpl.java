package org.longxin.service.impl;

import org.longxin.dao.L1ComponentDAO;
import org.longxin.domains.L1Component;
import org.longxin.service.L1ComponentService;
import org.springframework.beans.factory.annotation.Autowired;

public class L1ComponentServiceImpl implements L1ComponentService
{
	@Autowired
	L1ComponentDAO l1ComponentDAO;
	
	public L1Component getL1ComponentByID(Integer ID)
	{
		return l1ComponentDAO.getL1ComponentByID(ID);
	}
}
