package org.longxin.service;

import java.util.List;

import org.longxin.domains.ChangeHistory;

public interface ChangeHistoryService
{
    public void saveChangeHistory(ChangeHistory changeHistory);
    
    public List<ChangeHistory> getChangeHistoryByReferenceAndCategory(int referenceId, String category);
}

