package org.longxin.dao.impl;

import org.longxin.dao.FunctionDAO;
import org.longxin.domains.Function;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class FunctionServiceImpl extends HibernateDaoSupport implements FunctionDAO
{
	public void saveFunction(Function function)
	{
		this.getHibernateTemplate().saveOrUpdate(function);
	}

}
