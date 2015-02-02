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
		this.getHibernateTemplate().delete(this.getHibernateTemplate().get(L3Component.class, id));
	}

}
