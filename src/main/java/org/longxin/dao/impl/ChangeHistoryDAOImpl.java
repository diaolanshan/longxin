package org.longxin.dao.impl;

import java.util.List;

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

    @SuppressWarnings("unchecked")
    @Override
    public List<ChangeHistory> getChangeHistoryByReferenceAndCategory(int referenceId, String category)
    {
        return (List<ChangeHistory>)this.getHibernateTemplate().find("FROM ChangeHistory WHERE referenceId = ? AND category =? ORDER BY ID ASC", referenceId, category);
    }
}

