package org.longxin.dao.impl;

import org.longxin.dao.L1ComponentDAO;
import org.longxin.domains.L1Component;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class L1ComponentDAOImpl extends HibernateDaoSupport implements L1ComponentDAO
{
	public L1Component getL1ComponentByID(Integer ID)
	{
		return this.getHibernateTemplate().get(L1Component.class, ID);
	}
}
