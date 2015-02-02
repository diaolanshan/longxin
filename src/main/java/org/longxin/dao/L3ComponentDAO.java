package org.longxin.dao;

import org.longxin.domains.L3Component;

public interface L3ComponentDAO
{
	public L3Component getL3ComponentByID(Integer ID);
	
	public void updateL3Component(L3Component l3Component);
	
	public void addL3Component(L3Component l3Component);
	
	public void deleteL3Component(int id);
}
