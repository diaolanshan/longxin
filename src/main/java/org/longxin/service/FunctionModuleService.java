package org.longxin.service;

import java.util.List;

import org.longxin.domains.Feature;
import org.longxin.domains.FunctionModule;

public interface FunctionModuleService
{
    public void saveFunctionModule(FunctionModule functionModule);
    
    public List<FunctionModule> getFunctionModulesByFeature(Feature feature);
    
}

