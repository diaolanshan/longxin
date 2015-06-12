package org.longxin.service;

import java.util.List;

import org.longxin.domains.L1Component;
import org.longxin.domains.Module;

public interface L1ComponentService
{
	public L1Component getL1ComponentByID(Integer ID);
	
	public L1Component getL1ComponentByIDForDragram(Integer ID);
	
	public List<L1Component> getL1ComponentsByModule(Module module);

	public void updateL1Component(L1Component l1Component);

	public void addL1Component(L1Component l1Component);
	
	public void deleteL1Component(int id);
	
	public int getFeatureId(int l1ComponentId);
	
	public boolean isThereDraftParamterForComponent(int l1ComponentId);
	
	public void updateL1Component(int componentId, int functionModuleId);
	
	public List<L1Component> searchByKeywords(String keywords);
}
