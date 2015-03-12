package org.longxin.service;

import java.util.List;

import org.longxin.domains.Feature;
import org.longxin.domains.Product;

public interface FeatureService
{
    public void saveFeatures(List<Feature> features);
    
    public List<Feature> getFeatureByProduct(Product product);
    
    public Feature getFeatureByID(Integer featureID);
    
    public void saveFeature(Feature feature);
}
