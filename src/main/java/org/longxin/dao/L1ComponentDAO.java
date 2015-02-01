package org.longxin.dao;

import java.util.List;

import org.longxin.domains.L1Component;
import org.longxin.domains.L1ComponentParameter;
import org.longxin.domains.L2Component;

public interface L1ComponentDAO
{
	public L1Component getL1ComponentByID(Integer ID);
	
	public List<L2Component> getL2ComponentsByL1(L1Component l1Component);
}
