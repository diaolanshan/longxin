package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.FunctionModuleDAO;
import org.longxin.domains.Feature;
import org.longxin.domains.FunctionModule;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class FunctionModuleDAOImpl extends HibernateDaoSupport implements FunctionModuleDAO
{

    @Override
    public void saveFunctionModule(FunctionModule functionModule)
    {
       this.getHibernateTemplate().saveOrUpdate(functionModule);

    }

    @SuppressWarnings("unchecked")
    @Override
    public List<FunctionModule> getFunctionModulesByFeature(Feature feature)
    {
        List<FunctionModule> modules = (List<FunctionModule>) this.getHibernateTemplate().find("FROM FunctionModule WHERE feature = ?", feature);

        return modules;
    }
    
    /**
     * Get the FunctionModule object by the primary key.
     */
    @Override
    public FunctionModule getFunctionModuleById(int functionModuleId)
    {
    	return this.getHibernateTemplate().load(FunctionModule.class, functionModuleId);
    }
}

