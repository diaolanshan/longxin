package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.L1ComponentParameterDAO;
import org.longxin.domains.L1Component;
import org.longxin.domains.L1ComponentParameter;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class L1ComponentParameterDAOImpl extends HibernateDaoSupport implements L1ComponentParameterDAO
{

	public L1Component getL1ComponentByID(Integer ID)
	{
		// TODO Auto-generated method stub
		return null;
	}

	public List<L1ComponentParameter> getL1Parameters(L1Component component)
	{
		return this.getHibernateTemplate().find("FROM L1ComponentParameter l1 WHERE l1.l1Component= ?", component);
	}

	@Override
	public void addParameter(L1ComponentParameter l1parameter) {
		
		this.getHibernateTemplate().saveOrUpdate(l1parameter);
	}
}
