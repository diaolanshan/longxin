package org.longxin.service;

import java.util.List;

import org.longxin.domains.L1Component;
import org.longxin.domains.L1ComponentParameter;

public interface L1ComponentParameterService
{
	public List<L1ComponentParameter> getL1Paramters(L1Component component);
	
	public void addParameter(L1ComponentParameter l1parameter);
}
