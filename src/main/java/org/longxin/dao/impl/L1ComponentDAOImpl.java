package org.longxin.dao.impl;

import java.math.BigInteger;
import java.util.List;

import org.longxin.dao.L1ComponentDAO;
import org.longxin.domains.FunctionModule;
import org.longxin.domains.L1Component;
import org.longxin.domains.Module;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class L1ComponentDAOImpl extends HibernateDaoSupport implements L1ComponentDAO
{
    public L1Component getL1ComponentByID(Integer ID)
    {
        return this.getHibernateTemplate().get(L1Component.class, ID);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<L1Component> getL1ComponentsByModule(Module module)
    {
        List<L1Component> l1Components = (List<L1Component>) this.getHibernateTemplate().find(
            "FROM L1Component WHERE module = ? ORDER BY ID ASC",
            module);

        return l1Components;
    }
    
    @Override
    public void updateL1Component(L1Component l1Component)
    {
        this.getHibernateTemplate().update(l1Component);
    }

    @Override
    public void addL1Component(L1Component l1Component)
    {
        this.getHibernateTemplate().save(l1Component);
    }

    @Override
    public void deleteL1Component(int id)
    {
        L1Component l1 = this.getHibernateTemplate().get(L1Component.class, id);
        this.getHibernateTemplate().delete(l1);
    }
    
    public boolean isThereDraftParamterForComponent(int l1ComponentId)
    {
        StringBuilder query = new StringBuilder();
        query.append("SELECT COUNT(DISTINCT(l1.id)) ");
        query.append("FROM l1_component l1 ");
        query.append("LEFT JOIN l1_component_parameter l1p ON l1p.L1_COMPONENT = l1.id  ");
        query.append("WHERE l1p.IS_DRAFT = 1 AND l1.id = ");
        query.append(l1ComponentId);
                
        BigInteger result = (BigInteger)this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createSQLQuery(query.toString()).list().get(0);
        
        if (result.intValue() > 0)
        {
            return true;
        }
        return false;
    }
    
    public void updateL1Component(int componentId, int functionModuleId)
    {
        Integer value = (functionModuleId == 0? null: functionModuleId);
        this.getHibernateTemplate().getSessionFactory().getCurrentSession().createSQLQuery("UPDATE L1_COMPONENT SET FUNCTION_MODULE = " + value + " WHERE ID = "  + componentId).executeUpdate();
    }
    
    public void resetL1ComponentMatrix(int featureId)
    {
        StringBuilder updateString = new StringBuilder();
        updateString.append("UPDATE L1_COMPONENT SET FUNCTION_MODULE = null WHERE MODULE IN (");
        updateString.append(" SELECT ID FROM MODULE WHERE FEATURE = ");
        updateString.append(featureId).append(" )");
        
        this.getHibernateTemplate().getSessionFactory().getCurrentSession().createSQLQuery(updateString.toString()).executeUpdate();
    }
    
    @SuppressWarnings("unchecked")
    public List<L1Component> searchByKeywords(String keywords)
    {
        keywords = "%" + keywords + "%";
        List<L1Component> results = this
                .getHibernateTemplate()
                .find(
                    "FROM L1Component component WHERE component.name like ? OR component.description like ? OR component.functionName like ?",
                    keywords,
                    keywords,
                    keywords);
        
        for(L1Component result : results)
        {
            result.setSearched(true);
        }
        
        return results;
    }

	@Override
	public List<L1Component> getL1ComponentsByFunctionModule(
			FunctionModule functionModule) {
		  @SuppressWarnings("unchecked")
		List<L1Component> l1Components = (List<L1Component>) this.getHibernateTemplate().find(
		            "FROM L1Component WHERE functionModule = ? ORDER BY ID ASC",
		            functionModule);

		        return l1Components;
	}
}
