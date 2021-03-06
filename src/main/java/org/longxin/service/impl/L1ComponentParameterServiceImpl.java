package org.longxin.service.impl;

import java.util.List;

import org.longxin.dao.L1ComponentParameterDAO;
import org.longxin.domains.L1Component;
import org.longxin.domains.L1ComponentParameter;
import org.longxin.service.AttachmentService;
import org.longxin.service.L1ComponentParameterService;
import org.springframework.beans.factory.annotation.Autowired;

public class L1ComponentParameterServiceImpl implements L1ComponentParameterService
{
    @Autowired
    L1ComponentParameterDAO l1ComponentParameterDAO;

    @Autowired
    AttachmentService attachmentService;;

    public List<L1ComponentParameter> getL1Paramters(L1Component component)
    {
        return this.l1ComponentParameterDAO.getL1Parameters(component);

    }

    @Override
    public void addParameter(L1ComponentParameter l1parameter)
    {
        this.l1ComponentParameterDAO.addParameter(l1parameter);

    }

    @Override
    public void deleteParameter(int id)
    {
        this.l1ComponentParameterDAO.deleteParameter(id);
        attachmentService.deleteAttachmentsByCategoryAndRefID("L1COMPONENTPARAMETER", id);
    }

    @Override
    public void updateParameter(L1ComponentParameter l1parameter)
    {
        
        this.l1ComponentParameterDAO.updateParameter(l1parameter);
    }

    @Override
    public L1ComponentParameter getL1ComponentParamtersByID(Integer ID)
    {
        return this.l1ComponentParameterDAO.getL1ComponentParameterByID(ID);
    }

    @Override
    public List<L1ComponentParameter> searchByKeywords(String keywords)
    {
       return this.l1ComponentParameterDAO.searchByKeywords(keywords);
    }
}
