package org.longxin.dao;

import java.util.List;

import org.longxin.domains.L2Component;
import org.longxin.domains.L3Component;

public interface L3ComponentDAO
{
	public L3Component getL3ComponentByID(Integer ID);
	
	public List<L3Component> getL3ComponentsByL2(L2Component l2Component);
	
	public void updateL3Component(L3Component l3Component);
	
	public void addL3Component(L3Component l3Component);
	
	public void deleteL3Component(int id);
	
	public boolean isThereDraftParamterForComponent(int l3ComponentId);
}
