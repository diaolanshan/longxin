package org.longxin.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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

    @Override
    public List<ChangeHistory> getChangeHistoryByReferenceAndCategory(int referenceId, String category)
    {
        List<ChangeHistory> historys = changeHistoryDAO.getChangeHistoryByReferenceAndCategory(referenceId, category);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        
        for(ChangeHistory history:historys)
        {
            history.setDisplayUpdateAt(sdf.format(history.getUpdatedat()));
        }
        
        return historys;
    }
}

