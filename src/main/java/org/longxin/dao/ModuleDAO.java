package org.longxin.dao;

import java.util.List;

import org.longxin.domains.Feature;
import org.longxin.domains.Module;

public interface ModuleDAO
{
	public void saveFunction(Module module);
	
	public List<Module> getModulesByFeature(Feature feature);
	
	public Module getModuleByID(Integer moduleID);
}
