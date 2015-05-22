package org.longxin.service.impl;

import java.util.List;

import org.longxin.dao.ModuleDAO;
import org.longxin.domains.Feature;
import org.longxin.domains.L1Component;
import org.longxin.domains.Module;
import org.longxin.service.ModuleService;
import org.springframework.beans.factory.annotation.Autowired;

public class ModuleServiceImpl implements ModuleService
{

    @Autowired
    ModuleDAO moduleDAO;
    
    public void saveFunctions(List<Module> modules)
    {
        
    }

    public List<Module> getModulesByFeature(Feature feature)
    {
        return moduleDAO.getModulesByFeature(feature);
    }
    
    public List<Module> getModulesByFeatureWithChild(Feature feature)
    {
        List<Module> modules = moduleDAO.getModulesByFeature(feature);
        for (Module module : modules)
        {
            if (module.getL1Components() != null)
            {
                for (L1Component l1 : module.getL1Components())
                {
                    l1.getName();
                }
            }
        }
        return modules;
    }

    public Module getModuleByID(Integer moduleID)
    {
        return moduleDAO.getModuleByID(moduleID);
    }

    @Override
    public void updateModule(Module module) {
        moduleDAO.updateModule(module);
    }

    @Override
    public void deleteModule(int id) {
        moduleDAO.deleteModuleByID(id);
    }
    
}
