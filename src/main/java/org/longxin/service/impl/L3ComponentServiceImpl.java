package org.longxin.service.impl;

import org.longxin.dao.L3ComponentDAO;
import org.longxin.domains.L3Component;
import org.longxin.service.L3ComponentService;
import org.springframework.beans.factory.annotation.Autowired;

public class L3ComponentServiceImpl implements L3ComponentService
{
	@Autowired
	L3ComponentDAO l3ComponentDAO;
	
	public L3Component getL3ComponentByID(Integer ID)
	{
		return l3ComponentDAO.getL3ComponentByID(ID);
	}
}
