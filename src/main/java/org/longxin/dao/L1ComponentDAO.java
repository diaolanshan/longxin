package org.longxin.dao;

import java.util.List;

import org.longxin.domains.L1Component;
import org.longxin.domains.Module;

public interface L1ComponentDAO
{
	public L1Component getL1ComponentByID(Integer ID);
	
	public List<L1Component> getL1ComponentsByModule(Module module);
	
	public void updateL1Component(L1Component l1Component);

	public void addL1Component(L1Component l1Component);
	
	public void deleteL1Component(int id);
	
	public boolean isThereDraftParamterForComponent(int l1ComponentId);
	
	public void updateL1Component(int componentId, int functionModuleId);
	
	public void resetL1ComponentMatrix(int featureId);
}
