package org.longxin.dao.impl;

import org.longxin.dao.L2ComponentDAO;
import org.longxin.domains.L2Component;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class L2ComponentDAOImpl extends HibernateDaoSupport implements L2ComponentDAO
{
	public L2Component getL2ComponentByID(Integer ID)
	{
		return this.getHibernateTemplate().get(L2Component.class, ID);
	}
}
