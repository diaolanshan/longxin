package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.FeatureDAO;
import org.longxin.domains.Feature;
import org.longxin.domains.Product;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class FeatureDAOImpl extends HibernateDaoSupport implements FeatureDAO
{
    public void saveFeature(Feature feature)
    {
        this.getHibernateTemplate().saveOrUpdate(feature);
    }

    @SuppressWarnings("unchecked")
    public List<Feature> getFeatureByProduct(Product product)
    {
        return (List<Feature>) this.getHibernateTemplate().find("FROM Feature WHERE product = ? ORDER BY ID ASC", product);
    }

    public Feature getFeatureByID(Integer featureID)
    {
        return this.getHibernateTemplate().get(Feature.class, featureID);
    }

    public void deleteFeatureByID(Integer featureID)
    {
        Feature feature = getFeatureByID(featureID);
        this.getHibernateTemplate().delete(feature);
    }
}
