package org.longxin.dao.impl;

import java.math.BigInteger;
import java.util.List;

import org.longxin.dao.L2ComponentDAO;
import org.longxin.domains.L1Component;
import org.longxin.domains.L2Component;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class L2ComponentDAOImpl extends HibernateDaoSupport implements L2ComponentDAO
{
	public L2Component getL2ComponentByID(Integer ID)
	{
		return this.getHibernateTemplate().get(L2Component.class, ID);
	}

    @SuppressWarnings("unchecked")
    @Override
    public List<L2Component> getL2ComponentsByL1(L1Component l1Component)
    {
        List<L2Component> l2Components = (List<L2Component>) this.getHibernateTemplate().find(
            "FROM L2Component WHERE l1Component = ? ORDER BY ID ASC",
            l1Component);

        return l2Components;
    }
	
	@Override
	public void updateL2Component(L2Component l2Component) {
		this.getHibernateTemplate().update(l2Component);
	}

	@Override
	public void addL2Component(L2Component l2Component) {
		this.getHibernateTemplate().save(l2Component);
	}

	@Override
	public void deleteL2Component(int id) {
		L2Component l2 = this.getHibernateTemplate().get(L2Component.class,id);
		this.getHibernateTemplate().delete(l2);
	}
	
	public boolean isThereDraftParamterForComponent(int l2ComponentId)
    {
        StringBuilder query = new StringBuilder();
        query.append("SELECT COUNT(DISTINCT(l2.id)) ");
        query.append("FROM l2_component l2 ");
        query.append("LEFT JOIN l2_component_parameter l2p ON l2p.L2_COMPONENT = l2.id  ");
        query.append("WHERE l2p.IS_DRAFT = 1 AND l2.id = ");
        query.append(l2ComponentId);
                
        BigInteger result = (BigInteger)this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createSQLQuery(query.toString()).list().get(0);
        
        if (result.intValue() > 0)
        {
            return true;
        }
        return false;
    }
	
    @SuppressWarnings("unchecked")
    public List<L2Component> searchByKeywords(String keywords)
    {
        keywords = "%" + keywords + "%";
        List<L2Component> results = this
                .getHibernateTemplate()
                .find(
                    "FROM L2Component component WHERE component.name like ? OR component.description like ? OR component.functionName like ?",
                    keywords,
                    keywords,
                    keywords);
        
        
        for(L2Component result : results)
        {
            result.setSearched(true);
        }
        
        return results;
    }
}
