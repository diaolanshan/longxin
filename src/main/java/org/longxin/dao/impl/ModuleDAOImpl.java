package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.ModuleDAO;
import org.longxin.domains.Feature;
import org.longxin.domains.Module;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class ModuleDAOImpl extends HibernateDaoSupport implements ModuleDAO
{
    public void saveModule(Module module)
    {
        this.getHibernateTemplate().saveOrUpdate(module);
    }

    @SuppressWarnings("unchecked")
    public List<Module> getModulesByFeature(Feature feature)
    {
        List<Module> modules = (List<Module>) this.getHibernateTemplate().find("FROM Module WHERE feature = ?", feature);

        return modules;
    }

    public Module getModuleByID(Integer moduleID)
    {
        return this.getHibernateTemplate().get(Module.class, moduleID);
    }

    @Override
    public void updateModule(Module module) {
        this.getHibernateTemplate().saveOrUpdate(module);
    }

    @Override
    public void deleteModuleByID(Integer moduleID) {
        Module module = this.getHibernateTemplate().get(Module.class,moduleID);
        this.getHibernateTemplate().delete(module);
    }
    
    @SuppressWarnings("unchecked")
    public List<Module> searchByKeywords(String keywords)
    {
        keywords = "%" + keywords + "%";
        List<Module> results = this
                .getHibernateTemplate()
                .find(
                    "FROM Module module WHERE module.moduleName like ? OR module.description like ? OR module.functionName like ?",
                    keywords,
                    keywords,
                    keywords);
        
        for(Module result : results)
        {
            result.setSearched(true);
        }
        
        return results;
    }
}
