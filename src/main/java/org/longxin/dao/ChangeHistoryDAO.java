package org.longxin.dao;

import java.util.List;

import org.longxin.domains.ChangeHistory;

public interface ChangeHistoryDAO {

	public void saveOrUpdateChangeHistory(ChangeHistory changeHistory);
	
	public List<ChangeHistory> getChangeHistoryByReferenceAndCategory(int referenceId, String category);
	
}
