package org.longxin.service.impl;

import java.util.List;

import org.longxin.dao.RequirementsDAO;
import org.longxin.domains.Product;
import org.longxin.domains.Requirements;
import org.longxin.service.RequirementsService;
import org.springframework.beans.factory.annotation.Autowired;

public class RequirementServiceImpl implements RequirementsService
{

    @Autowired
    RequirementsDAO requirementsDAO;
    
    @Override
    public void saveOrUpdateRequirements(Requirements requirement)
    {
        this.requirementsDAO.saveOrUpdateRequirements(requirement);
    }

    @Override
    public List<Requirements> getRequirementsByProduct(Product product)
    {
        return this.requirementsDAO.getRequirementsByProduct(product);
    }

    @Override
    public Requirements getRequirementById(int id)
    {
        return this.requirementsDAO.getRequirementById(id);
    }

    @Override
    public void deleteRequirement(int id)
    {
        this.requirementsDAO.deleteRequirement(id);
    }

    @Override
    public List<Requirements> getRequirementBySeqName(String sequenceName)
    {
       return this.requirementsDAO.getRequirementBySeqName(sequenceName);
    }
}

