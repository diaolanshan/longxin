package org.longxin.web.controller;

import org.longxin.domains.ChangeHistory;
import org.longxin.domains.ComponentParameter;
import org.longxin.domains.Users;
import org.longxin.service.ChangeHistoryService;
import org.longxin.service.UserService;
import org.longxin.util.OperationType;
import org.springframework.beans.factory.annotation.Autowired;

public abstract class ComponentContoller
{
    @Autowired
    UserService userService;

    @Autowired
    ChangeHistoryService changeHistoryService;
    
    protected void trackChange(ComponentParameter parameter, Users user, OperationType operationType)
    {
        ChangeHistory change = new ChangeHistory();

        change.setOldValue(parameter.getParameterValue());
        change.setNewValue(parameter.getDraftValue());
        change.setOperator(user);
        change.setOperationType(operationType);
        change.setCategory(parameter.getCategory());
        change.setReferenceId(parameter.getId());

        changeHistoryService.saveChangeHistory(change);
    }
}

