package org.longxin.dao;

import java.util.List;

import org.longxin.domains.L2Component;
import org.longxin.domains.L2ComponentParameter;

public interface L2ComponentParameterDAO
{
	public List<L2ComponentParameter> getL2Parameters(L2Component component);
	
	public void addParameter(L2ComponentParameter l2parameter);
	
	public void deleteParameter(int id);
	
	public void updateParameter(L2ComponentParameter l2parameter);
	
	public L2ComponentParameter getL2ComponentParamtersByID(Integer id);
	
	public List<L2ComponentParameter> searchByKeywords(String keywords);
}
