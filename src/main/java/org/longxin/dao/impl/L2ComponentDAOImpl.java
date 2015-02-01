package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.L2ComponentDAO;
import org.longxin.domains.L2Component;
import org.longxin.domains.L3Component;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class L2ComponentDAOImpl extends HibernateDaoSupport implements L2ComponentDAO
{
	public L2Component getL2ComponentByID(Integer ID)
	{
		return this.getHibernateTemplate().get(L2Component.class, ID);
	}

	@Override
	public List<L3Component> getL3ComponentsByL2(L2Component l2Component) {
		List<L3Component> l3Components = (List<L3Component>) this.getHibernateTemplate().find("FROM L3Component WHERE L2 = ?", l2Component);

		return l3Components;
	}
}
