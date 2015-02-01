package org.longxin.dao;

import java.util.List;

import org.longxin.domains.L1Component;
import org.longxin.domains.L1ComponentParameter;

public interface L1ComponentParameterDAO
{
	public L1Component getL1ComponentByID(Integer ID);
	
	public List<L1ComponentParameter> getL1Parameters(L1Component component);
	
	public void addParameter(L1ComponentParameter l1parameter);
}
