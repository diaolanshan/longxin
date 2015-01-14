package org.longxin.dao;

import java.util.List;

import org.longxin.domains.Feature;

public interface FeatureDAO
{
	public void saveFeature(Feature feature);
	
	public List<Feature> getFeatureByProductId(int id);
}
