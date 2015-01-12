package org.longxin.dao.impl;

import org.longxin.dao.FeatureDAO;
import org.longxin.domains.Feature;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class FeatureDAOImpl extends HibernateDaoSupport implements FeatureDAO
{
	public void saveFeature(Feature feature)
	{
		this.getHibernateTemplate().saveOrUpdate(feature);
	}
}
