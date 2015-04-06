package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.L3ComponentParameterDAO;
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
}
