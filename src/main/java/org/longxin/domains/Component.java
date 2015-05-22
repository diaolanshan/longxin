package org.longxin.domains;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
public class Component
{
    private Boolean isDraft;
    
    @Column(name = "IS_DRAFT")
    public Boolean getIsDraft()
    {
        return isDraft;
    }

    public void setIsDraft(Boolean isDraft)
    {
        this.isDraft = isDraft;
    }

}

