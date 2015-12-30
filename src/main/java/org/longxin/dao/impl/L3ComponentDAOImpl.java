package org.longxin.dao.impl;

import java.math.BigInteger;
import java.util.List;

import org.longxin.dao.L3ComponentDAO;
import org.longxin.domains.L2Component;
import org.longxin.domains.L3Component;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class L3ComponentDAOImpl extends HibernateDaoSupport implements L3ComponentDAO
{
	public L3Component getL3ComponentByID(Integer ID)
	{
		return this.getHibernateTemplate().get(L3Component.class, ID);
	}

	@Override
	public void updateL3Component(L3Component l3Component) {
		this.getHibernateTemplate().update(l3Component);
	}

	@Override
	public void addL3Component(L3Component l3Component) {
		this.getHibernateTemplate().save(l3Component);
	}

	@Override
	public void deleteL3Component(int id) {
		L3Component l3 = this.getHibernateTemplate().get(L3Component.class,id);
		this.getHibernateTemplate().delete(l3);
	}

    @SuppressWarnings("unchecked")
    @Override
    public List<L3Component> getL3ComponentsByL2(L2Component l2Component)
    {
        List<L3Component> l3Components = (List<L3Component>) this.getHibernateTemplate().find(
            "FROM L3Component WHERE l2Component = ? ORDER BY ID ASC",
            l2Component);

        return l3Components;
    }
    
    public boolean isThereDraftParamterForComponent(int l3ComponentId)
    {
        StringBuilder query = new StringBuilder();
        query.append("SELECT COUNT(DISTINCT(l3.id)) ");
        query.append("FROM l3_component l3 ");
        query.append("LEFT JOIN l3_component_parameter l3p ON l3p.L3_COMPONENT = l3.id  ");
        query.append("WHERE l3p.IS_DRAFT = 1 AND l3.id = ");
        query.append(l3ComponentId);
                
        BigInteger result = (BigInteger)this.getHibernateTemplate().getSessionFactory().getCurrentSession()
                .createSQLQuery(query.toString()).list().get(0);
        
        if (result.intValue() > 0)
        {
            return true;
        }
        return false;
    }
    
    @SuppressWarnings("unchecked")
    public List<L3Component> searchByKeywords(String keywords)
    {
        keywords = "%" + keywords + "%";
        List<L3Component> results = this
                .getHibernateTemplate()
                .find(
                    "FROM L3Component component WHERE component.name like ? OR component.description like ? OR component.functionName like ?",
                    keywords,
                    keywords,
                    keywords);
        
        for(L3Component result : results)
        {
            result.setSearched(true);
        }
        
        return results;
    }
}
