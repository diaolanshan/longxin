package org.longxin.dao.impl;

import org.longxin.dao.ChangeHistoryDAO;
import org.longxin.domains.ChangeHistory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

public class ChangeHistoryDAOImpl extends HibernateDaoSupport implements ChangeHistoryDAO
{

    @Override
    public void saveOrUpdateChangeHistory(ChangeHistory changeHistory)
    {
        this.getHibernateTemplate().saveOrUpdate(changeHistory);
    }
}

