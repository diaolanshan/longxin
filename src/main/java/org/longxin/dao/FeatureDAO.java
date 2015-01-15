package org.longxin.dao;

import java.util.List;

import org.longxin.domains.Feature;
import org.longxin.domains.Product;

public interface FeatureDAO
{
	public void saveFeature(Feature feature);
	
	public List<Feature> getFeatureByProduct(Product product);
}
