package org.longxin.service.impl;

import java.util.List;

import org.longxin.dao.L1ComponentDAO;
import org.longxin.domains.L1Component;
import org.longxin.domains.L2Component;
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

	@Override
	public List<L2Component> getL2ComponentsByL1(L1Component l1Component) {
		return l1ComponentDAO.getL2ComponentsByL1(l1Component);
	}

	@Override
	public void updateL1Component(L1Component l1Component) {
		l1ComponentDAO.updateL1Component(l1Component);
	}

	@Override
	public void addL1Component(L1Component l1Component) {
		l1ComponentDAO.addL1Component(l1Component);
	}

	@Override
	public void deleteL1Component(int id) {
		l1ComponentDAO.deleteL1Component(id);
	}
}
