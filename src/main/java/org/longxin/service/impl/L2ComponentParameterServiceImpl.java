package org.longxin.service.impl;

import java.util.List;

import org.longxin.dao.L2ComponentParameterDAO;
import org.longxin.domains.L2Component;
import org.longxin.domains.L2ComponentParameter;
import org.longxin.service.L2ComponentParameterService;
import org.springframework.beans.factory.annotation.Autowired;

public class L2ComponentParameterServiceImpl implements L2ComponentParameterService
{
    @Autowired
    L2ComponentParameterDAO l2ComponentParameterDAO;

    public List<L2ComponentParameter> getL2Paramters(L2Component component)
    {
        return this.l2ComponentParameterDAO.getL2Parameters(component);

    }

    @Override
    public void addParameter(L2ComponentParameter l2parameter)
    {
        this.l2ComponentParameterDAO.addParameter(l2parameter);
    }

    @Override
    public void deleteParameter(int id)
    {
        this.l2ComponentParameterDAO.deleteParameter(id);
    }

    @Override
    public void updateParameter(L2ComponentParameter l2parameter)
    {
        this.l2ComponentParameterDAO.updateParameter(l2parameter);
    }

    @Override
    public L2ComponentParameter getL2ComponentParamtersByID(Integer ID)
    {
        return this.l2ComponentParameterDAO.getL2ComponentParamtersByID(ID);
    }
}
