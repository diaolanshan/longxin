package org.longxin.service;

import java.util.List;

import org.longxin.domains.Feature;
import org.longxin.domains.Product;
import org.longxin.web.controller.bean.MatrixBean;
import org.longxin.web.controller.bean.Surounder;

public interface FeatureService
{
    public void saveFeatures(List<Feature> features);
    
    public List<Feature> getFeatureByProduct(Product product);
    
    public Feature getFeatureByID(Integer featureID);
    
    public void saveFeature(Feature feature);
    
    public void deleteFeatureById(Integer featureID);
    
    public List<MatrixBean> generateFunctionMatrix(int featureId);
    
    public void updateFunctionMatrix(Surounder rounder ,int featureId);
}
