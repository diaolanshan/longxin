package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.RequirementsDAO;
import org.longxin.domains.Product;
import org.longxin.domains.Requirements;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class RequirementsDAOImpl extends HibernateDaoSupport implements RequirementsDAO
{
    @Override
    public void saveOrUpdateRequirements(Requirements requirement)
    {
        this.getHibernateTemplate().saveOrUpdate(requirement);
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Requirements> getRequirementsByProduct(Product product)
    {
        return this.getHibernateTemplate().find("FROM Requirements r WHERE r.product = ?", product);
    }

    @Override
    public Requirements getRequirementById(int id)
    {
        return this.getHibernateTemplate().load(Requirements.class, id);
    }

    @Override
    public void deleteRequirement(int id)
    {
        this.getHibernateTemplate().delete(this.getHibernateTemplate().load(Requirements.class, id));
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Requirements> getRequirementBySeqName(String sequenceName)
    {
        return this.getHibernateTemplate().find("FROM Requirements r WHERE r.sequence = ?", sequenceName);
    }
}

