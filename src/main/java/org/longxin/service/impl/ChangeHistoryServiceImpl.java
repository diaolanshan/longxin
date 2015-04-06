package org.longxin.service.impl;

import java.util.Date;

import org.longxin.dao.ChangeHistoryDAO;
import org.longxin.domains.ChangeHistory;
import org.longxin.service.ChangeHistoryService;
import org.springframework.beans.factory.annotation.Autowired;

public class ChangeHistoryServiceImpl implements ChangeHistoryService
{
    @Autowired
    ChangeHistoryDAO changeHistoryDAO;
    
    @Override
    public void saveChangeHistory(ChangeHistory changeHistory)
    {
        changeHistory.setUpdatedat(new Date());
        
        changeHistoryDAO.saveOrUpdateChangeHistory(changeHistory);
    }
}

