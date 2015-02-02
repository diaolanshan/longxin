package org.longxin.service;

import java.util.List;

import org.longxin.domains.Feature;
import org.longxin.domains.Module;

public interface ModuleService
{
	public void saveFunctions(List<Module> modules);
	
	public List<Module> getModulesByFeature(Feature feature);
	
	public Module getModuleByID(Integer moduleID);
	
	public void updateModule(Module module);
	
}
