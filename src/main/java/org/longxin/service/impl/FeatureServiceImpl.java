package org.longxin.service.impl;

import java.util.List;

import org.longxin.dao.FeatureDAO;
import org.longxin.domains.Feature;
import org.longxin.domains.Product;
import org.longxin.service.FeatureService;
import org.springframework.beans.factory.annotation.Autowired;

public class FeatureServiceImpl implements FeatureService
{
    @Autowired
    FeatureDAO featureDAO;
    
    public void saveFeatures(List<Feature> features)
    {
        for(Feature feature : features)
        {
            this.saveFeature(feature);
        }
    }
    
    public List<Feature> cloneFeatures(List<Feature> features)
    {
        return null;
    }

    public void saveFeature(Feature features)
    {
        featureDAO.saveFeature(features);
    }

    public List<Feature> getFeatureByProduct(Product product) {
        return featureDAO.getFeatureByProduct(product);
    }

    public Feature getFeatureByID(Integer featureID)
    {
        return featureDAO.getFeatureByID(featureID);
    }

}
