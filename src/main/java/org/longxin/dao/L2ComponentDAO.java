package org.longxin.dao;

import java.util.List;

import org.longxin.domains.L2Component;
import org.longxin.domains.L3Component;

public interface L2ComponentDAO
{
	public L2Component getL2ComponentByID(Integer ID);
	
	public List<L3Component> getL3ComponentsByL2(L2Component l2Component);
	
	public void updateL2Component(L2Component l2Component);

	public void addL2Component(L2Component l2Component);
	
	public void deleteL2Component(int id);
}
