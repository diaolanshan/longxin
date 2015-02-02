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

	@Override
	public void updateL3Component(L3Component l3Component) {
		l3ComponentDAO.updateL3Component(l3Component);
	}

	@Override
	public void addL3Component(L3Component l3Component) {
		l3ComponentDAO.addL3Component(l3Component);
	}

	@Override
	public void deleteL3Component(int id) {
		l3ComponentDAO.deleteL3Component(id);
	}
}
