package org.longxin.service;

import java.util.List;

import org.longxin.domains.L1Component;
import org.longxin.domains.L2Component;

public interface L2ComponentService
{
	public L2Component getL2ComponentByID(Integer ID);
	
	public List<L2Component> getL2ComponentsByL1(L1Component l1Component);

	public void updateL2Component(L2Component l2Component);

	public void addL2Component(L2Component l2Component);
	
	public void deleteL2Component(int id);
	
	public int getFeatureId(int l2ComponentId);
	
	public boolean isThereDraftParamterForComponent(int l2ComponentId);
}
