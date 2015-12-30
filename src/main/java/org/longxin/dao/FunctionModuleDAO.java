package org.longxin.dao;

import java.util.List;

import org.longxin.domains.Feature;
import org.longxin.domains.FunctionModule;

public interface FunctionModuleDAO
{
    public void saveFunctionModule(FunctionModule functionModule);
    
    public List<FunctionModule> getFunctionModulesByFeature(Feature feature);
    
    public FunctionModule getFunctionModuleById(int functionModuleId);
}

