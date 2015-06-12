package org.longxin.dao;

import java.util.List;

import org.longxin.domains.L2Component;
import org.longxin.domains.L3Component;
import org.longxin.domains.L3ComponentParameter;

public interface L3ComponentParameterDAO
{
	public L3Component getL3ComponentByID(Integer ID);
	
	public List<L3ComponentParameter> getL3Parameters(L3Component component);
	
	public List<L3Component> getL3ComponentsByL2(L2Component l2Component);
	
	public void addParameter(L3ComponentParameter l3parameter);
	
	public void deleteParameter(int id);
	
	public void updateParameter(L3ComponentParameter l3parameter);
	
	public L3ComponentParameter getL3ComponentParamtersByID(Integer parameterId);
	
	public List<L3ComponentParameter> searchByKeywords(String keywords);
}
