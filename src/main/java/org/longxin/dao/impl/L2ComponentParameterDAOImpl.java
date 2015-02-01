package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.L2ComponentParameterDAO;
import org.longxin.domains.L2Component;
import org.longxin.domains.L2ComponentParameter;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class L2ComponentParameterDAOImpl extends HibernateDaoSupport implements L2ComponentParameterDAO
{

	public L2Component getL2ComponentByID(Integer ID)
	{
		// TODO Auto-generated method stub
		return null;
	}

	public List<L2ComponentParameter> getL2Parameters(L2Component component)
	{
		return this.getHibernateTemplate().find("FROM L2ComponentParameter l2 WHERE l2.l2Component= ?", component);
	}

	@Override
	public void addParameter(L2ComponentParameter l2parameter) {
		
		this.getHibernateTemplate().saveOrUpdate(l2parameter);
		
	}
}
