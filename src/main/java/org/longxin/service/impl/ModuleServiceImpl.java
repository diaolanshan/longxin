package org.longxin.service.impl;

import java.util.List;

import org.longxin.dao.ModuleDAO;
import org.longxin.domains.Feature;
import org.longxin.domains.L1Component;
import org.longxin.domains.L2Component;
import org.longxin.domains.L3Component;
import org.longxin.domains.Module;
import org.longxin.service.ModuleService;
import org.springframework.beans.factory.annotation.Autowired;

public class ModuleServiceImpl implements ModuleService
{
    @Autowired
    ModuleDAO moduleDAO;
    
    public void saveModules(List<Module> modules)
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

    @Override
    public Module getModuleByIDForDiagram(Integer moduleID)
    {
        Module module = moduleDAO.getModuleByID(moduleID);
        
        if (module.getL1Components() != null)
        {
            for (L1Component l1Component : module.getL1Components())
            {
                if (l1Component.getL2Components() != null)
                {
                    for (L2Component l2Component : l1Component.getL2Components())
                    {
                        if (l2Component.getL3Components() != null)
                        {
                            for (L3Component l3Component : l2Component.getL3Components())
                            {
                                l3Component.getName();
                            }
                        }
                    }
                }
            }
        }
        
        return module;
    }

    @Override
    public List<Module> searchByKeywords(String keywords)
    {
        return this.moduleDAO.searchByKeywords(keywords);
    }
}
