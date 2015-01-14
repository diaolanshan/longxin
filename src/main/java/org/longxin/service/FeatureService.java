package org.longxin.service;

import java.util.List;

import org.longxin.domains.Feature;

public interface FeatureService
{
	public void saveFeatures(List<Feature> features);
	
	public List<Feature> getFeatureByProductId(int id);
}
