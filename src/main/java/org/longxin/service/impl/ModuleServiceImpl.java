package org.longxin.service.impl;

import java.util.List;

import org.longxin.dao.ModuleDAO;
import org.longxin.domains.Feature;
import org.longxin.domains.Module;
import org.longxin.service.ModuleService;
import org.springframework.beans.factory.annotation.Autowired;

public class ModuleServiceImpl implements ModuleService
{

	@Autowired
	ModuleDAO moduleDAO;
	
	public void saveFunctions(List<Module> modules)
	{
		// TODO Auto-generated method stub
		
	}

	public List<Module> getModulesByFeature(Feature feature)
	{
		return moduleDAO.getModulesByFeature(feature);
	}

	public Module getModuleByID(Integer moduleID)
	{
		return moduleDAO.getModuleByID(moduleID);
	}

	@Override
	public void updateModule(Module module) {
		moduleDAO.updateModule(module);
	}
	
}
