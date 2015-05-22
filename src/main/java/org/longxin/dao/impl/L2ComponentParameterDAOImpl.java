package org.longxin.dao.impl;

import java.util.List;

import org.longxin.dao.L2ComponentParameterDAO;
import org.longxin.domains.L2ComponentParameter;
import org.longxin.domains.L2Component;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class L2ComponentParameterDAOImpl extends HibernateDaoSupport implements L2ComponentParameterDAO
{

    public L2ComponentParameter getL2ComponentParamtersByID(Integer id)
    {
        return this.getHibernateTemplate().get(L2ComponentParameter.class, id);
    }

    @SuppressWarnings("unchecked")
    public List<L2ComponentParameter> getL2Parameters(L2Component component)
    {
        return this.getHibernateTemplate().find("FROM L2ComponentParameter l2 WHERE l2.l2Component= ?", component);
    }

    @Override
    public void addParameter(L2ComponentParameter l2parameter)
    {
        this.getHibernateTemplate().saveOrUpdate(l2parameter);
    }

    @Override
    public void deleteParameter(int id)
    {
        L2ComponentParameter l2 = this.getHibernateTemplate().get(L2ComponentParameter.class, id);
        this.getHibernateTemplate().delete(l2);
    }

    @Override
    public void updateParameter(L2ComponentParameter l2parameter)
    {
        this.getHibernateTemplate().update(l2parameter);
    }
}
