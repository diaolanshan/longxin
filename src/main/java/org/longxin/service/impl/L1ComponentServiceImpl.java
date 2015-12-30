package org.longxin.service.impl;

import java.util.List;

import org.longxin.dao.L1ComponentDAO;
import org.longxin.domains.Feature;
import org.longxin.domains.L1Component;
import org.longxin.domains.L2Component;
import org.longxin.domains.L3Component;
import org.longxin.domains.Module;
import org.longxin.service.L1ComponentService;
import org.springframework.beans.factory.annotation.Autowired;

public class L1ComponentServiceImpl implements L1ComponentService
{
	@Autowired
	L1ComponentDAO l1ComponentDAO;
	
	
	public L1Component getL1ComponentByID(Integer ID)
	{
		return l1ComponentDAO.getL1ComponentByID(ID);
	}
	
    public L1Component getL1ComponentByIDForDragram(Integer ID)
    {
        L1Component l1Component = l1ComponentDAO.getL1ComponentByID(ID);
        if (l1Component.getL2Components() != null)
        {
            for (L2Component l2Component : l1Component.getL2Components())
            {
                if (l2Component.getL3Components() != null)
                {
                    for (L3Component l3Component : l2Component.getL3Components())
                    {
                        l3Component.getName();
                    }
                }
            }
        }
        return l1Component;
    }

	@Override
	public void updateL1Component(L1Component l1Component) {
		l1ComponentDAO.updateL1Component(l1Component);
	}

	@Override
	public void addL1Component(L1Component l1Component) {
		l1ComponentDAO.addL1Component(l1Component);
	}

	@Override
	public void deleteL1Component(int id) {
		l1ComponentDAO.deleteL1Component(id);
	}

    @Override
    public List<L1Component> getL1ComponentsByModule(Module module)
    {
        return l1ComponentDAO.getL1ComponentsByModule(module);
    }
    
    public int getFeatureId(int l1ComponentId)
    {
        L1Component component = l1ComponentDAO.getL1ComponentByID(l1ComponentId);
        Feature feature = component.getModule().getFeature();
        return feature.getId();
    }

    @Override
    public boolean isThereDraftParamterForComponent(int l1ComponentId)
    {
        return this.l1ComponentDAO.isThereDraftParamterForComponent(l1ComponentId);
    }

    @Override
    public void updateL1Component(int componentId, int functionModuleId)
    {
       this.l1ComponentDAO.updateL1Component(componentId, functionModuleId);
    }

    @Override
    public List<L1Component> searchByKeywords(String keywords)
    {
       return this.l1ComponentDAO.searchByKeywords(keywords);
    }
}
