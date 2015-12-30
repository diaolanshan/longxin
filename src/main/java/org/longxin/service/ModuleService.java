package org.longxin.service;

import java.util.List;

import org.longxin.domains.Feature;
import org.longxin.domains.Module;

public interface ModuleService
{
    public void saveModules(List<Module> modules);
    
    public List<Module> getModulesByFeature(Feature feature);
    
    public Module getModuleByID(Integer moduleID);
    
    public Module getModuleByIDForDiagram(Integer moduleID);
    
    public void updateModule(Module module);
    
    public void deleteModule(int id);
    
    public List<Module> getModulesByFeatureWithChild(Feature feature);
    
    public List<Module> searchByKeywords(String keywords);
}
