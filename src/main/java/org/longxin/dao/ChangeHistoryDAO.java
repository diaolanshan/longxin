package org.longxin.dao;

import org.longxin.domains.ChangeHistory;

public interface ChangeHistoryDAO {

	public void saveOrUpdateChangeHistory(ChangeHistory changeHistory);
	
}
