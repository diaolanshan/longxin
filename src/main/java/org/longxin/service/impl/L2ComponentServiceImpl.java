package org.longxin.service.impl;

import java.util.List;

import org.longxin.dao.L2ComponentDAO;
import org.longxin.domains.Feature;
import org.longxin.domains.L1Component;
import org.longxin.domains.L2Component;
import org.longxin.domains.L3Component;
import org.longxin.service.L2ComponentService;
import org.springframework.beans.factory.annotation.Autowired;

public class L2ComponentServiceImpl implements L2ComponentService
{
	@Autowired
	L2ComponentDAO l2ComponentDAO;
	
	public L2Component getL2ComponentByID(Integer ID)
	{
		return l2ComponentDAO.getL2ComponentByID(ID);
	}
	
	public L2Component getL2ComponentByIDForDiagram(Integer ID)
    {
        L2Component l2Component = l2ComponentDAO.getL2ComponentByID(ID);
        
        if (l2Component.getL3Components() != null)
        {
            for (L3Component l3Component : l2Component.getL3Components())
            {
                l3Component.getName();
            }
        }
        
        return l2Component;
    }

	@Override
    public List<L2Component> getL2ComponentsByL1(L1Component l1Component) {
        return l2ComponentDAO.getL2ComponentsByL1(l1Component);
    }

	@Override
	public void updateL2Component(L2Component l2Component) {
		l2ComponentDAO.updateL2Component(l2Component);
	}

	@Override
	public void addL2Component(L2Component l2Component) {
		l2ComponentDAO.addL2Component(l2Component);
	}

	@Override
	public void deleteL2Component(int id) {
		l2ComponentDAO.deleteL2Component(id);
	}
	
	public int getFeatureId(int l2ComponentId)
    {
        L2Component component = l2ComponentDAO.getL2ComponentByID(l2ComponentId);
        Feature feature = component.getL1Component().getModule().getFeature();
        return feature.getId();
    }

    @Override
    public boolean isThereDraftParamterForComponent(int l2ComponentId)
    {
        return this.l2ComponentDAO.isThereDraftParamterForComponent(l2ComponentId);
    }

    @Override
    public List<L2Component> searchByKeywords(String keywords)
    {
        return this.l2ComponentDAO.searchByKeywords(keywords);
    }
}
