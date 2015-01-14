package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.FeatureDAO;
import org.longxin.domains.Feature;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class FeatureDAOImpl extends HibernateDaoSupport implements FeatureDAO
{
	public void saveFeature(Feature feature)
	{
		this.getHibernateTemplate().saveOrUpdate(feature);
	}

	@SuppressWarnings("unchecked")
	public List<Feature> getFeatureByProductId(int id) {
		List<Feature> features = (List<Feature>) this.getHibernateTemplate().find("FROM Feature WHERE Feature.product = ?", id);

		if (features != null)
		{
			return features;
		}

		return null;
	}
}
