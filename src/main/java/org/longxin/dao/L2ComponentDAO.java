package org.longxin.dao;


import java.util.List;

import org.longxin.domains.L1Component;
import org.longxin.domains.L2Component;

public interface L2ComponentDAO
{
	public L2Component getL2ComponentByID(Integer ID);
	
	public List<L2Component> getL2ComponentsByL1(L1Component l1Component);
	
	public void updateL2Component(L2Component l2Component);

	public void addL2Component(L2Component l2Component);
	
	public void deleteL2Component(int id);
	
	public boolean isThereDraftParamterForComponent(int l1ComponentId);
	
	public List<L2Component> searchByKeywords(String keywords);
}
