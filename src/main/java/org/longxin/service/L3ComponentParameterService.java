package org.longxin.service;

import java.util.List;

import org.longxin.domains.L3Component;
import org.longxin.domains.L3ComponentParameter;

public interface L3ComponentParameterService
{
	public List<L3ComponentParameter> getL3Paramters(L3Component component);
	
	public void addParameter(L3ComponentParameter l3parameter);
	
	public void deleteParameter(int id);
	
	public void updateParameter(L3ComponentParameter l3parameter);
	
	public L3ComponentParameter getL3ComponentParamtersByID(Integer parameterId);
}
