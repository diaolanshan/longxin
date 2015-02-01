package org.longxin.dao.impl;

import org.longxin.dao.L3ComponentDAO;
import org.longxin.domains.L3Component;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class L3ComponentDAOImpl extends HibernateDaoSupport implements L3ComponentDAO
{
	public L3Component getL3ComponentByID(Integer ID)
	{
		return this.getHibernateTemplate().get(L3Component.class, ID);
	}

}
