package org.longxin.service.impl;

import java.util.List;

import org.longxin.dao.L3ComponentDAO;
import org.longxin.domains.Feature;
import org.longxin.domains.L2Component;
import org.longxin.domains.L3Component;
import org.longxin.service.L3ComponentService;
import org.springframework.beans.factory.annotation.Autowired;

public class L3ComponentServiceImpl implements L3ComponentService
{
	@Autowired
	L3ComponentDAO l3ComponentDAO;
	
	public L3Component getL3ComponentByID(Integer ID)
	{
		return l3ComponentDAO.getL3ComponentByID(ID);
	}
	
    @Override
    public List<L3Component> getL3ComponentsByL2(L2Component l2Component)
    {
        return l3ComponentDAO.getL3ComponentsByL2(l2Component);
    }

	@Override
	public void updateL3Component(L3Component l3Component) {
		l3ComponentDAO.updateL3Component(l3Component);
	}

	@Override
	public void addL3Component(L3Component l3Component) {
		l3ComponentDAO.addL3Component(l3Component);
	}

	@Override
	public void deleteL3Component(int id) {
		l3ComponentDAO.deleteL3Component(id);
	}
	
	public int getFeatureId(int l3ComponentId)
    {
        L3Component component = l3ComponentDAO.getL3ComponentByID(l3ComponentId);
        Feature feature = component.getL2Component().getL1Component().getModule().getFeature();
        return feature.getId();
    }

    @Override
    public boolean isThereDraftParamterForComponent(int l3ComponentId)
    {
        return this.l3ComponentDAO.isThereDraftParamterForComponent(l3ComponentId);
    }

    @Override
    public List<L3Component> searchByKeywords(String keywords)
    {
        return this.l3ComponentDAO.searchByKeywords(keywords);
    }
}
