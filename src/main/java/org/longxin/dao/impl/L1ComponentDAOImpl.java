package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.L1ComponentDAO;
import org.longxin.domains.L1Component;
import org.longxin.domains.L2Component;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class L1ComponentDAOImpl extends HibernateDaoSupport implements L1ComponentDAO
{
	public L1Component getL1ComponentByID(Integer ID)
	{
		return this.getHibernateTemplate().get(L1Component.class, ID);
	}

	@Override
	public List<L2Component> getL2ComponentsByL1(L1Component l1Component) {
		List<L2Component> l2Components = (List<L2Component>) this.getHibernateTemplate().find("FROM L2Component WHERE L1 = ?", l1Component);

		return l2Components;
	}

	@Override
	public void updateL1Component(L1Component l1Component) {
		this.getHibernateTemplate().update(l1Component);
	}

	@Override
	public void addL1Component(L1Component l1Component) {
		this.getHibernateTemplate().save(l1Component);
	}

	@Override
	public void deleteL1Component(int id) {
		L1Component l1 = this.getHibernateTemplate().get(L1Component.class,id);
		this.getHibernateTemplate().delete(l1);
	}

}
