package org.longxin.service.impl;

import java.util.List;

import org.longxin.dao.FunctionModuleDAO;
import org.longxin.domains.Feature;
import org.longxin.domains.FunctionModule;
import org.longxin.service.FunctionModuleService;
import org.springframework.beans.factory.annotation.Autowired;

public class FunctionModuleServiceImpl implements FunctionModuleService
{

    @Autowired
    FunctionModuleDAO functionModuleDAO;
    
    @Override
    public void saveFunctionModule(FunctionModule functionModule)
    {
        functionModuleDAO.saveFunctionModule(functionModule);
    }

    @Override
    public List<FunctionModule> getFunctionModulesByFeature(Feature feature)
    {
        return functionModuleDAO.getFunctionModulesByFeature(feature);
    }
   
    @Override
    public FunctionModule getFunctionModuleById(int functionModuleId)
    {
    	return functionModuleDAO.getFunctionModuleById(functionModuleId);
    }
}

