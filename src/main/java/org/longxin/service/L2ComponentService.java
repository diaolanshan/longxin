package org.longxin.service;

import java.util.List;

import org.longxin.domains.L2Component;
import org.longxin.domains.L3Component;

public interface L2ComponentService
{
	public L2Component getL2ComponentByID(Integer ID);

	public List<L3Component> getL3ComponentsByL2(L2Component l2Component);
}
