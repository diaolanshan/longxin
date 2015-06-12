package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.L3ComponentParameterDAO;
import org.longxin.domains.L2Component;
import org.longxin.domains.L3Component;
import org.longxin.domains.L3ComponentParameter;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class L3ComponentParameterDAOImpl extends HibernateDaoSupport implements L3ComponentParameterDAO
{

	public L3Component getL3ComponentByID(Integer ID)
	{
		// TODO Auto-generated method stub
		return null;
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
	
	@SuppressWarnings("unchecked")
    public List<L3ComponentParameter> getL3Parameters(L3Component component)
	{
		return this.getHibernateTemplate().find("FROM L3ComponentParameter l3 WHERE l3.l3Component= ?", component);
	}

	@Override
	public void addParameter(L3ComponentParameter l3parameter) {
		
		this.getHibernateTemplate().saveOrUpdate(l3parameter);
	}

	@Override
	public void deleteParameter(int id) {
		L3ComponentParameter l3 = this.getHibernateTemplate().get(L3ComponentParameter.class,id);
		this.getHibernateTemplate().delete(l3);
	}

	@Override
	public void updateParameter(L3ComponentParameter l3parameter) {
		this.getHibernateTemplate().update(l3parameter);
	}

    @Override
    public L3ComponentParameter getL3ComponentParamtersByID(Integer parameterId)
    {
        return this.getHibernateTemplate().get(L3ComponentParameter.class, parameterId);
    }
    
    @SuppressWarnings("unchecked")
    public List<L3ComponentParameter> searchByKeywords(String keywords)
    {
        keywords = "%" + keywords + "%";
        List<L3ComponentParameter> results =
                this.getHibernateTemplate()
                .find(
                    "FROM L3ComponentParameter parameter WHERE parameter.parameterName like ? OR parameter.parameterValue like ? OR parameter.options like ? OR parameter.minValue like ? OR parameter.maxValue like ? OR parameter.draftValue like ?",
                    keywords,
                    keywords,
                    keywords,
                    keywords,
                    keywords,
                    keywords);
        for(L3ComponentParameter parameter : results)
        {
            parameter.setSearched(true);
        }
        
        return results;
    }
}
