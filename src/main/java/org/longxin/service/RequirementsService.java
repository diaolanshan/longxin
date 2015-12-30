package org.longxin.service;

import java.util.List;

import org.longxin.domains.Product;
import org.longxin.domains.Requirements;

public interface RequirementsService
{
    public void saveOrUpdateRequirements(Requirements requirement);
    
    public List<Requirements> getRequirementsByProduct(Product product);
    
    public Requirements getRequirementById(int id);
    
    public void deleteRequirement(int id);
    
    public List<Requirements> getRequirementBySeqName(String sequenceName);
}

