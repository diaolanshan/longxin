package org.longxin.web.controller;

import java.util.List;

import org.longxin.domains.ChangeHistory;
import org.longxin.domains.ComponentParameter;
import org.longxin.domains.Users;
import org.longxin.service.ChangeHistoryService;
import org.longxin.service.UserService;
import org.longxin.util.OperationType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

public abstract class ComponentContoller
{
    @Autowired
    UserService userService;

    @Autowired
    ChangeHistoryService changeHistoryService;
    
    protected void trackChange(ComponentParameter parameter, Users user, OperationType operationType)
    {
        ChangeHistory change = new ChangeHistory();

        if (operationType == OperationType.CHANGE)
        {
            if (!StringUtils.isEmpty(parameter.getTempParameterValue()))
            {
                if (parameter.getTempParameterValue().equalsIgnoreCase(parameter.getDraftValue()))
                {
                    // no update.
                    return;
                }
            }
        }
        
        change.setOldValue(parameter.getTempParameterValue());
        change.setNewValue(parameter.getDraftValue());
        change.setOperator(user);
        change.setOperationType(operationType);
        change.setCategory(parameter.getCategory());
        change.setReferenceId(parameter.getId());
        change.setComments(parameter.getChangeReason());

        changeHistoryService.saveChangeHistory(change);
    }
    
    @RequestMapping(value = "/history/parameter/{category}/{parameterId}", method = RequestMethod.GET)
    protected @ResponseBody
    List<ChangeHistory> getChangeHistory(@PathVariable String category, @PathVariable int parameterId)
    {
        return changeHistoryService.getChangeHistoryByReferenceAndCategory(parameterId, category);
    }
}

